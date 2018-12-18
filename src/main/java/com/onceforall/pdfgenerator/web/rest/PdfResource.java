package com.onceforall.pdfgenerator.web.rest;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.onceforall.pdfgenerator.json.JSONException;
import com.onceforall.pdfgenerator.service.PdfService;
import com.onceforall.pdfgenerator.web.rest.vm.PdfGenerationDataVM;

@RestController
@RequestMapping("/api/v1/pdf")
public class PdfResource {

    private final ObjectMapper objectMapper;
    
    private final PdfService pdfService;

    public PdfResource(PdfService pdfService) {
        this.objectMapper = new ObjectMapper();
        this.objectMapper.findAndRegisterModules();
        this.objectMapper.disable(DeserializationFeature.ADJUST_DATES_TO_CONTEXT_TIME_ZONE);
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ");
        this.objectMapper.setDateFormat(df);
        this.pdfService = pdfService;
    }

    @PostMapping(value = "/generate", consumes = MediaType.APPLICATION_JSON_VALUE)
    @ResponseStatus(HttpStatus.OK)
    public void generate(HttpServletResponse response, @Valid @RequestBody PdfGenerationDataVM pdfGenerationData) throws IOException, JSONException {
        
    	ByteArrayOutputStream baos = pdfService.generate(pdfGenerationData.template, pdfGenerationData.data, pdfGenerationData.i18n);  
    	
        response.setContentType("text/html");
        response.addHeader(
            "Content-Disposition",
            "attachment; filename=generated.pdf");
        response.setContentLength(baos.size());
        baos.writeTo(response.getOutputStream());
    }
}
