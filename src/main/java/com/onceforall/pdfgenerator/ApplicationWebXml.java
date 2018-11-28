package com.onceforall.pdfgenerator;

import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

import com.onceforall.pdfgenerator.config.DefaultProfileUtil;


/**
 * This is a helper Java class that provides an alternative to creating a web.xml.
 * This will be invoked only when the application is deployed to a Servlet container like Tomcat, JBoss etc.
 */
public class ApplicationWebXml extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        /**
         * set a default to use when no profile is configured.
         */
        DefaultProfileUtil.addDefaultProfile(application.application());
        return application.sources(PdfGeneratorApp.class);
    }
}
