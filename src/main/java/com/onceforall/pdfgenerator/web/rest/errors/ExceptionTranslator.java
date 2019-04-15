package com.onceforall.pdfgenerator.web.rest.errors;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.annotation.AnnotationUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.ResponseEntity.BodyBuilder;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.onceforall.pdfgenerator.exception.InternalException;

/**
 * Controller advice to translate the server side exceptions to client-friendly json structures.
 */
@ControllerAdvice
public class ExceptionTranslator {

    private static final Logger LOGGER = LoggerFactory.getLogger(ExceptionTranslator.class);

    /**
     * Required as our @DataClass doesn't define getter and setter to access properties
     */
    @InitBinder
    public void initBinder(WebDataBinder binder) {
       binder.initDirectFieldAccess();
    }

    /* Do not delete between comments (Non internal error)  */
    
    @ExceptionHandler(MethodArgumentNotValidException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ResponseBody
    public ErrorVM processValidationError(MethodArgumentNotValidException ex) {
        
    	BindingResult result = ex.getBindingResult();
        List<FieldError> fieldErrors = result.getFieldErrors();
        
        ErrorVM erroVM = new ErrorVM(ErrorConstants.ERR_VALIDATION);
        List<FieldErrorVM> fieldErrorVMs = new ArrayList<>();
        for (FieldError fieldError : fieldErrors) {
        	fieldErrorVMs.add(new FieldErrorVM(fieldError.getObjectName(), fieldError.getField(), fieldError.getDefaultMessage()));
        }
        erroVM.addAdditionnalData("FieldErrors", fieldErrorVMs);
        
        return erroVM;
    }

    @ExceptionHandler(IllegalArgumentException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ResponseBody
    public ErrorVM processIllegalArgumentException(IllegalArgumentException ex) {
        return new ErrorVM(ErrorConstants.ERR_ILLEGAL_ARGUMENT, ex.getMessage());
    }
    
    @ExceptionHandler(AccessDeniedException.class)
    @ResponseStatus(HttpStatus.FORBIDDEN)
    @ResponseBody
    public ErrorVM processAccessDeniedException(AccessDeniedException ex) {
        return new ErrorVM(ErrorConstants.ERR_ACCESS_DENIED, ex.getMessage());
    }

    @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
    @ResponseBody
    @ResponseStatus(HttpStatus.METHOD_NOT_ALLOWED)
    public ErrorVM processMethodNotSupportedException(HttpRequestMethodNotSupportedException exception) {
        return new ErrorVM(ErrorConstants.ERR_METHOD_NOT_SUPPORTED, exception.getMessage());
    }
    
    /* Do not delete between comments (Non internal error)  */
    
    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorVM> processException(Exception ex) {
        BodyBuilder builder;
        ErrorVM errorVM;
        ResponseStatus responseStatus = AnnotationUtils.findAnnotation(ex.getClass(), ResponseStatus.class);
        if (ex instanceof InternalException) {
        	InternalException internalException = (InternalException) ex;
        	builder = ResponseEntity.status(internalException.getStatusCode());
        	errorVM = new ErrorVM(internalException.getCode(), internalException.getMessage());
        	errorVM.addAdditionnalData(internalException.getAdditionnalData());
        } else if (responseStatus != null) {
            builder = ResponseEntity.status(responseStatus.value());
            errorVM = new ErrorVM("error." + responseStatus.value().value(), responseStatus.reason());
        }  else {
            builder = ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR);
            errorVM = new ErrorVM(ErrorConstants.ERR_INTERNAL_SERVER_ERROR, "Internal server error");
            if (LOGGER.isDebugEnabled()) {
                errorVM.addAdditionnalData("StackTraceElements", Arrays.asList(ex.getStackTrace()));
            }
        }
        return builder.body(errorVM);
    }
}
