part of 'upload_bloc.dart';

@immutable
class UploadState extends Equatable {
  final bool issubmitted;
  final bool isEtractingText;
  final bool isUploadingToStorage;
  final bool isUploadingData;
  final bool isTitleValid;
  final bool isSuccess;
  final bool isFailure;

  const UploadState._({
    @required this.issubmitted,
    @required this.isEtractingText,
    @required this.isUploadingData,
    @required this.isUploadingToStorage,
    @required this.isTitleValid,
    @required this.isSuccess,
    @required this.isFailure,
  })  : assert(issubmitted != null),
        assert(isEtractingText != null),
        assert(isUploadingData != null),
        assert(isUploadingToStorage != null),
        assert(isTitleValid != null),
        assert(isSuccess != null),
        assert(isFailure != null);

  factory UploadState.initial() {
    return UploadState._(
      issubmitted: false,
      isEtractingText: false,
      isUploadingData: false,
      isUploadingToStorage: false,
      isTitleValid: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory UploadState.submitted() {
    return UploadState._(
      issubmitted: true,
      isEtractingText: false,
      isUploadingData: false,
      isUploadingToStorage: false,
      isTitleValid: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory UploadState.success() {
    return UploadState._(
      issubmitted: true,
      isEtractingText: false,
      isUploadingData: false,
      isUploadingToStorage: false,
      isTitleValid: true,
      isSuccess: true,
      isFailure: false,
    );
  }

  factory UploadState.failure() {
    return UploadState._(
      issubmitted: true,
      isEtractingText: false,
      isUploadingData: false,
      isUploadingToStorage: false,
      isTitleValid: true,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory UploadState.extractingText() {
    return UploadState._(
      issubmitted: true,
      isEtractingText: true,
      isUploadingData: false,
      isUploadingToStorage: false,
      isTitleValid: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory UploadState.uploadingToStorage() {
    return UploadState._(
      issubmitted: true,
      isEtractingText: false,
      isUploadingData: false,
      isUploadingToStorage: true,
      isTitleValid: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory UploadState.uploadingData() {
    return UploadState._(
      issubmitted: true,
      isEtractingText: false,
      isUploadingData: true,
      isUploadingToStorage: false,
      isTitleValid: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return '''UploadState(
      issubmitted: $issubmitted, 
      isEtractingText: $isEtractingText, 
      isUploadingToStorage: $isUploadingToStorage, 
      isUploadingData: $isUploadingData, 
      isTitleValid: $isTitleValid, 
      isSuccess: $isSuccess, 
      isFailure: $isFailure)''';
  }
}

//title
//comment
//tags

//add new tag

// submitted
// uploading to storage
// uploaded to storage
// extracting text
// extracted text
// uploading data to db
// uploaded data to db
