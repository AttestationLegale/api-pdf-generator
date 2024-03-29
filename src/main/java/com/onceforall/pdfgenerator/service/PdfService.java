package com.onceforall.pdfgenerator.service;

import com.itextpdf.html2pdf.ConverterProperties;
import com.itextpdf.html2pdf.HtmlConverter;
import com.itextpdf.styledxmlparser.css.media.MediaDeviceDescription;
import com.itextpdf.styledxmlparser.css.media.MediaType;
import com.onceforall.pdfgenerator.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.stringtemplate.v4.ST;

import java.io.ByteArrayOutputStream;
import java.util.Map;

@Service
public class PdfService {

    private static final Logger LOGGER = LoggerFactory.getLogger(PdfService.class);

    private final String baseUri;

    public PdfService(@Value("${application.base-uri}") final String baseUri) {
        this.baseUri = baseUri;
    }

    public ByteArrayOutputStream generate(String template, Map<String, Object> data, Map<String, Object> i18n) {

        long start = System.currentTimeMillis();

        ST stringTemplate = new ST(template, '$', '$');
        stringTemplate.add("data", new JSONObject(data));
        stringTemplate.add("i18n", new JSONObject(i18n));

        String html = stringTemplate.render();

        LOGGER.debug("Time to generate Html = " + (System.currentTimeMillis() - start));

        start = System.currentTimeMillis();

        ByteArrayOutputStream baos = new ByteArrayOutputStream();

        ConverterProperties properties = new ConverterProperties();
        properties.setBaseUri(baseUri);
        MediaDeviceDescription mediaDeviceDescription = new MediaDeviceDescription(MediaType.PRINT);
        properties.setMediaDeviceDescription(mediaDeviceDescription);

        HtmlConverter.convertToPdf(html, baos, properties);

        LOGGER.debug("Time to generate PDF = " + (System.currentTimeMillis() - start));

        return baos;
    }
}
