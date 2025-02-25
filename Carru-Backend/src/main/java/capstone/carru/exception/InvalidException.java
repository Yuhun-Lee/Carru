package capstone.carru.exception;

import capstone.carru.dto.ErrorCode;

public class InvalidException extends GeneralException {

    public InvalidException(String message, ErrorCode errorCode) {
        super(message, errorCode);
    }

    public InvalidException(String message) {
        super(message, ErrorCode.INVALID);
    }

    public InvalidException(ErrorCode errorCode) {
        super(errorCode);
    }
}
