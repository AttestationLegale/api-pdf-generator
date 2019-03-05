package com.onceforall.pdfgenerator.web.rest;

import com.onceforall.pdfgenerator.json.JSONException;
import com.onceforall.pdfgenerator.service.PdfService;
import com.onceforall.pdfgenerator.web.rest.vm.PdfGenerationDataVM;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.ByteArrayOutputStream;
import java.io.IOException;

@RestController
@RequestMapping("/api/v1/pdf")
public class PdfResource {

    private final PdfService pdfService;

    public PdfResource(PdfService pdfService) {
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
