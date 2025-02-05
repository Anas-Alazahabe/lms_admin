import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin/core/widgets/custom_loading.dart';
import 'package:lms_admin/features/subject_data/presentation/manager/comment_cubit/reply_cubit.dart';

class ReplyField extends StatefulWidget {
  final String lessonId;
  final bool isPosting;
  final bool isReplying;
  final String questionText;
  final String parentId;
  final String? replyId;
  const ReplyField(
      {super.key,
      required this.lessonId,
      required this.isPosting,
      required this.questionText,
      required this.parentId,
      required this.isReplying,
      this.replyId});

  @override
  State<ReplyField> createState() {
    return _ReplyFieldState();
  }
}

class _ReplyFieldState extends State<ReplyField> {
  final _commentController = TextEditingController();
  final _focusNode = FocusNode();
  // late String subString;
  // late String commentId;
  @override
  @override
  void initState() {
    super.initState();
    // _focusNode.addListener(_onFocusChange);
  }

  // void _onFocusChange() {
  //   if (!_focusNode.hasFocus) {
  //     setState(() {

  //       editing = false;
  //       _commentController.text = '';
  //     });
  //   }
  // }

  @override
  void dispose() {
    // _focusNode.removeListener(_onFocusChange);
    _commentController.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  void _submitMessage() async {
    final enteredMessage = _commentController.text;

    if (enteredMessage.trim().isEmpty) {
      return;
    }
    _commentController.clear();
    FocusScope.of(context).unfocus();
    if (!widget.isReplying) {
      BlocProvider.of<ReplyCubit>(context)
          .updateReply(comment: enteredMessage, commentId: widget.replyId!);
      return;
    } else {
      BlocProvider.of<ReplyCubit>(context).postReply(
          comment: enteredMessage,
          parentId: widget.parentId,
          lessonId: widget.lessonId);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isReplying) {
      _commentController.text = widget.questionText;
    } else {
      _commentController.clear();
    }
    return Column(
      children: [
        Container(
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.isReplying
                  ? Text('الرد على :${widget.questionText}')
                  : Text('تعديل:${widget.questionText}'),
            )),
        Row(
          children: [
            Expanded(
              child: TextField(
                focusNode: _focusNode,
                autofocus: true,
                controller: _commentController,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: widget.isReplying ? 'الاجابة...' : 'تعديل...',
                ),
              ),
            ),
            widget.isPosting
                ? const CustomLoading()
                : IconButton(
                    color: Theme.of(context).colorScheme.primary,
                    icon: const Icon(
                      Icons.arrow_upward_rounded,
                    ),
                    onPressed: _submitMessage,
                  ),
          ],
        ),
      ],
    );
  }
}
