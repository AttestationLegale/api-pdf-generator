package com.onceforall.pdfgenerator.web.rest.vm;

import javax.validation.constraints.NotNull;

import com.onceforall.pdfgenerator.config.DataClass;

@DataClass
public class PdfGenerationDataVM {

    @NotNull
    public String jsonData;
    @NotNull
    public String template;
    @NotNull
    public String i18nData;
    
    public PdfGenerationDataVM() {
        // used by Jackson
    }

    public PdfGenerationDataVM(String jsonData, String template, String i18nData) {
        this.jsonData = jsonData;
        this.template = template;
        this.i18nData = i18nData;
    }
}
