package com.onceforall.pdfgenerator.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.BAD_REQUEST)
public class DeleteDocumentException extends RuntimeException {

    public DeleteDocumentException(String message) {
        super(message);
    }
}
