part of 'upload_bloc.dart';

@immutable
class UploadState extends Equatable {
  final bool issubmitted;
  final bool isEtractingText;
  final bool isUploadingToStorage;
  final bool isUploadingData;
  final bool isSuccess;
  final bool isFailure;

  const UploadState._({
    @required this.issubmitted,
    @required this.isEtractingText,
    @required this.isUploadingData,
    @required this.isUploadingToStorage,
    @required this.isSuccess,
    @required this.isFailure,
  })  : assert(issubmitted != null),
        assert(isEtractingText != null),
        assert(isUploadingData != null),
        assert(isUploadingToStorage != null),
        assert(isSuccess != null),
        assert(isFailure != null);

  factory UploadState.initial() {
    return UploadState._(
      issubmitted: false,
      isEtractingText: false,
      isUploadingData: false,
      isUploadingToStorage: false,
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
      isSuccess: $isSuccess, 
      isFailure: $isFailure)''';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is UploadState &&
      o.issubmitted == issubmitted &&
      o.isEtractingText == isEtractingText &&
      o.isUploadingToStorage == isUploadingToStorage &&
      o.isUploadingData == isUploadingData &&
      o.isSuccess == isSuccess &&
      o.isFailure == isFailure;
  }

  @override
  int get hashCode {
    return issubmitted.hashCode ^
      isEtractingText.hashCode ^
      isUploadingToStorage.hashCode ^
      isUploadingData.hashCode ^
      isSuccess.hashCode ^
      isFailure.hashCode;
  }
}
