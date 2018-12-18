package com.onceforall.pdfgenerator.web.rest.vm;

import java.util.Map;

import javax.validation.constraints.NotNull;

import com.onceforall.pdfgenerator.config.DataClass;

@DataClass
public class PdfGenerationDataVM {

    @NotNull
    public Map<String, Object> data;
    @NotNull
    public String template;
    @NotNull
    public Map<String, Object> i18n;
    
    public PdfGenerationDataVM() {
        // used by Jackson
    }

    public PdfGenerationDataVM(Map<String, Object> data, String template, Map<String, Object> i18n) {
        this.data = data;
        this.template = template;
        this.i18n = i18n;
    }
}
