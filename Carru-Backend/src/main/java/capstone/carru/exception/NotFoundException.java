package capstone.carru.exception;

import capstone.carru.dto.ErrorCode;

public class NotFoundException extends GeneralException {

    public NotFoundException(String message, ErrorCode errorCode) {
        super(message, errorCode);
    }

    public NotFoundException(String message) {
        super(message, ErrorCode.NOT_EXISTS);
    }

    public NotFoundException(ErrorCode errorCode) {
        super(errorCode);
    }
}
