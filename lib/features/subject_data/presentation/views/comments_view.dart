import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/core/cubits/shared_preferences_cubit/shared_preferences_cubit.dart';
import 'package:lms_admin/core/utils/assets.dart';
import 'package:lms_admin/core/utils/functions/custom_toast.dart';
import 'package:lms_admin/core/utils/service_locator.dart';
import 'package:lms_admin/core/widgets/custom_error.dart';
import 'package:lms_admin/core/widgets/custom_loading.dart';
import 'package:lms_admin/features/subject_data/data/models/comments_model/comment_data.dart';
import 'package:lms_admin/features/subject_data/data/models/comments_model/comment_model.dart';
import 'package:lms_admin/features/subject_data/data/models/comments_model/reply.dart';
import 'package:lms_admin/features/subject_data/presentation/manager/comment_cubit/reply_cubit.dart';
import 'package:lms_admin/features/subject_data/presentation/manager/comments_cubit/comments_cubit.dart';
import 'package:lms_admin/features/subject_data/presentation/views/widgets/reply_field.dart';
import 'package:shimmer/shimmer.dart';

class CommentsView extends StatefulWidget {
  final String lessonId;
  const CommentsView({
    super.key,
    required this.lessonId,
  });

  @override
  State<CommentsView> createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {
  // late int length;
  bool lengthSet = false;
  bool posting = false;
  bool replying = false;
  bool editing = false;
  late String questionText;
  late String parentId;
  late int indexOfReply;
  String? replyId;
  final sharedPreferencesCubit = getIt<SharedPreferencesCubit>();
  late List<List<Reply>> replies;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    BlocProvider.of<CommentsCubit>(context)
        .fetchCommentsData(courseId: widget.lessonId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(),
        body: buildBody(),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text('ساحة نقاش'),
    );
  }

  Widget buildBody() {
    return BlocListener<ReplyCubit, ReplyState>(
      listener: (context, state) => handleReplyState(context, state),
      child: BlocConsumer<CommentsCubit, CommentsState>(
        listener: (BuildContext context, CommentsState state) {
          if (state is CommentsSuccess) {
            replies = List.generate(
              state.commentsModel.data!.length,
              (i) => List<Reply>.from(state.commentsModel.data![i].replies!),
            );
            for (int i = 0; i < state.commentsModel.data!.length; i++) {
              for (int j = 0;
                  j < state.commentsModel.data![i].replies!.length;
                  j++) {
                replies[i][j] = state.commentsModel.data![i].replies![j];
              }
            }
          }
        },
        builder: (context, state) {
          if (state is CommentsLoading) {
            return const CustomLoading();
          } else if (state is CommentsFailure) {
            return CustomError(errMessage: state.errMessage);
          } else if (state is CommentsSuccess) {
            return buildCommentsList(state);
          }
          return Container();
        },
      ),
    );
  }

  Widget buildCommentsList(CommentsSuccess state) {
    return Column(
      children: [
        Expanded(
          child: state.commentsModel.data!.isEmpty && replies.isEmpty
              ? const Center(child: Text('لا يوجد اسئلة'))
              : buildCommentsListView(state),
        ),
        if (replying || editing)
          ReplyField(
              isReplying: replying,
              parentId: parentId,
              questionText: questionText,
              lessonId: widget.lessonId,
              replyId: replyId,
              isPosting: posting),
      ],
    );
  }

  ListView buildCommentsListView(CommentsSuccess state) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: state.commentsModel.data!.length,
        itemBuilder: (context, index) =>
            buildCommentContainer(context, state, index));
  }

  Container buildCommentContainer(
      BuildContext context, CommentsSuccess state, int index) {
    CommentData currentComment =
        CommentData.fromSingleJson(state.commentsModel.data![index].toJson());

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: CommentTreeWidget<Comment, Comment>(
          Comment(
            avatar: 'null',
            userName: state.commentsModel.data![index].name,
            content: state.commentsModel.data![index].comment,
          ),
          index >= state.commentsModel.data!.length
              ? []
              : [
                  ...replies[index].map(
                    (e) => Comment(
                      avatar: 'null',
                      userName: e.name,
                      content: e.text,
                    ),
                  )
                ],
          treeThemeData: const TreeThemeData(
            lineColor: kAppColor,
            lineWidth: 3,
          ),
          avatarRoot: (context, data) => PreferredSize(
            preferredSize: Size.fromRadius(18),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(currentComment.imageIndex ==
                      null
                  ? AssetsData.profile
                  : AssetsData
                      .avatars[int.parse(currentComment.imageIndex!)]),
            ),
          ),
          avatarChild: (context, data) => const PreferredSize(
            preferredSize: Size.fromRadius(12),
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(AssetsData.logo),
            ),
          ),
          contentChild: (context, data) {
            return contentChild(data, context, index, state);
          },
          contentRoot: (context, data) {
            return contentRoot(data, context, index, state, currentComment);
          },
        ),
      ),
    );
  }

  Column contentChild(
      Comment data, BuildContext context, int index, CommentsSuccess state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: const BoxConstraints(
            minWidth: 100,
            minHeight: 70,
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${data.userName}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600, color: Colors.black),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                '${data.content}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w300, color: Colors.black),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            children: [
              const SizedBox(
                width: 8,
              ),
              DefaultTextStyle(
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.grey[700], fontWeight: FontWeight.bold),
                child: GestureDetector(
                  onTap: posting
                      ? null
                      : () {
                          questionText = data.content!;
                          parentId =
                              state.commentsModel.data![index].id.toString();

                          for (int i = 0; i < replies[index].length; i++) {
                            if (replies[index][i].text == data.content!) {
                              replyId = replies[index][i].id.toString();
                            }
                          }
                          setState(() {
                            editing = true;
                            replying = false;
                          });
                        },
                  child: const Text('تعديل'),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Column contentRoot(Comment data, BuildContext context, int index,
      CommentsSuccess state, CommentData currentComment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: const BoxConstraints(
            minWidth: 100,
            minHeight: 70,
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${data.userName}',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                '${data.content}',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.w300, color: Colors.black),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            children: [
              const SizedBox(
                width: 8,
              ),
              if (replies[index].isEmpty)
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.grey[700], fontWeight: FontWeight.bold),
                  child: GestureDetector(
                    onTap: posting
                        ? null
                        : () {
                            questionText = data.content!;
                            parentId =
                                state.commentsModel.data![index].id.toString();
                            indexOfReply = index;
                            // BlocProvider.of<ReplyCubit>(context).onSetReplyText(
                            //     data.content!,
                            //     state.commentsModel.data![index].id.toString());
                            setState(() {
                              editing = false;
                              replying = true;
                            });
                          },
                    child: const Text('اجابة'),
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }

  void handleReplyState(BuildContext context, ReplyState state) {
    if (state is ReplyFailure) {
      customToast(context, state.errMessage);
      setState(() {
        posting = false;
      });
    } else if (state is ReplyLoading) {
      setState(() {
        posting = true;
      });
    } else if (state is ReplySuccess) {
      posting = false;
      final reply = Reply(
        text: state.commentReply.comment!,
        id: state.commentReply.id,
        name: state.commentReply.name,
        // : state.commentReply.data!.id,
      );
      replies[indexOfReply].add(reply);

      setState(() {
        replying = false;
        editing = false;
      });
    } else if (state is EditingSuccess) {
      posting = false;
      for (int i = 0; i < replies.length; i++) {
        for (int j = 0; j < replies[i].length; j++) {
          if (replies[i][j].id == state.commentModel.id) {
            replies[i][j].text =  state.commentModel.comment;
          }
        }
      }
      setState(() {
        replying = false;
        editing = false;
        replyId = null;
      });
    }
    // Hide the reply field after editing
    // setState(() {
    //   replying = false;
    // });
  }
}
