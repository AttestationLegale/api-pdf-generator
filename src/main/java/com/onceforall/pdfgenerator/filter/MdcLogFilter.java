package com.onceforall.pdfgenerator.filter;

import com.google.common.collect.Maps;
import com.onceforall.pdfgenerator.PdfGeneratorApp;
import org.slf4j.MDC;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.Instant;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.ThreadLocalRandom;

public class MdcLogFilter extends OncePerRequestFilter {

    private static final String TRACE_ID_KEY = "X-OnceForAll-TraceId";
    private static final String SEPARATOR = "-";

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
        throws ServletException, IOException {

        Map<String, String> mdcContext = Maps.newHashMap();
        try {
            mdcContext.put(TRACE_ID_KEY, getTraceId(request));
            mdcContext.forEach(MDC::put);

            filterChain.doFilter(request, response);

        } finally {
            // Cleaning up our mess to avoid thread re-use collisions
            mdcContext.keySet().forEach(MDC::remove);
        }
    }

    private String getTraceId(HttpServletRequest request) {
        return Optional.ofNullable(request.getHeader(TRACE_ID_KEY)).orElseGet(MdcLogFilter::generateTraceId);
    }

    /**
     * Builds a traceId based on current system data to avoid collision
     */
    public static String generateTraceId() {

        StringBuilder traceIdBuilder = new StringBuilder();
        traceIdBuilder.append(PdfGeneratorApp.class.getSimpleName().toLowerCase());
        traceIdBuilder.append(SEPARATOR);
        traceIdBuilder.append(Instant.now().getEpochSecond());
        traceIdBuilder.append(SEPARATOR);
        traceIdBuilder.append(ThreadLocalRandom.current().nextInt(100));

        return traceIdBuilder.toString();
    }
}
