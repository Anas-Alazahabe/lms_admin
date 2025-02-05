import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/file.dart';
import 'package:lms_admin/features/subject_data/data/repo/subject_repo.dart';

part 'upload_state.dart';

class UploadFileCubit extends Cubit<UploadFileState> {
  final SubjectRepo subjectRepo;
  final Map<String, CancelToken> cancelTokens = {};

  UploadFileCubit(this.subjectRepo) : super(const UploadInitial('0'));

  Future<void> uploadFile(
      {required Filee file,
      required String uniqueName,
      required void Function(int, int)? onSendProgress}) async {
    try {
      CancelToken cancelToken = CancelToken();
      cancelTokens[uniqueName] = cancelToken;

      final result = await subjectRepo.postFile(
        file: file,
        cancelToken: cancelToken,
        onSendProgress: (received, total) {
          var progress = (received / total * 100);
          emit(UploadLoading(
              recived: received,
              total: total,
              progress: progress,
              uniqueName: uniqueName));
        },
      );
      result.fold((failure) {
        emit(UploadFailure(
            errMessage: failure.errMessage, uniqueId: uniqueName));
      }, (r) {
        emit(UploadSuccess(r, uniqueName: uniqueName));
      });
    } catch (e) {
      emit(UploadFailure(errMessage: e.toString(), uniqueId: uniqueName));
    }
  }

  // void cancelDownload(String uniqueName) {
  //   cancelTokens[uniqueName]?.cancel("تم إلغاء الرفع");
  //   emit(UploadInitial(uniqueName));
  // }
}
