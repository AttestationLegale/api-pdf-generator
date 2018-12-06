package com.onceforall.pdfgenerator.web.rest.vm;

import java.util.Map;

import javax.validation.constraints.NotNull;

import com.onceforall.pdfgenerator.config.DataClass;

@DataClass
public class PdfGenerationDataVM {

    @NotNull
    public Map<String, Object> jsonData;
    @NotNull
    public String template;
    @NotNull
    public Map<String, Object> i18nData;
    
    public PdfGenerationDataVM() {
        // used by Jackson
    }

    public PdfGenerationDataVM(Map<String, Object> jsonData, String template, Map<String, Object> i18nData) {
        this.jsonData = jsonData;
        this.template = template;
        this.i18nData = i18nData;
    }
}
