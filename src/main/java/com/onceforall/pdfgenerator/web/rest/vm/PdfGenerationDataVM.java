package com.onceforall.pdfgenerator.web.rest.vm;

import javax.validation.constraints.NotNull;

import com.onceforall.pdfgenerator.config.DataClass;

@DataClass
public class PdfGenerationDataVM {

    @NotNull
    public String jsonData;
    @NotNull
    public String template;

    public PdfGenerationDataVM() {
        // used by Jackson
    }

    public PdfGenerationDataVM(String jsonData, String template, String css) {
        this.jsonData = jsonData;
        this.template = template;
    }
}
