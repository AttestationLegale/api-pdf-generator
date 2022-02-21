package com.onceforall.pdfgenerator.config;

import com.onceforall.pdfgenerator.filter.MdcLogFilter;
import com.onceforall.pdfgenerator.security.AuthoritiesConstants;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableResourceServer;
import org.springframework.security.oauth2.config.annotation.web.configuration.ResourceServerConfigurerAdapter;
import org.springframework.security.oauth2.config.annotation.web.configurers.ResourceServerSecurityConfigurer;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;

@Configuration
@EnableResourceServer
@EnableGlobalMethodSecurity(prePostEnabled = true, securedEnabled = true)
public class MicroserviceSecurityConfiguration extends ResourceServerConfigurerAdapter {

    @Override
    public void configure(HttpSecurity http) throws Exception {
        http
            .addFilterAfter(new MdcLogFilter(), BasicAuthenticationFilter.class)
            .cors()
        .and()
            .csrf()
            .disable()
            .headers()
            .frameOptions().deny()
            .httpStrictTransportSecurity()
            .and()
        .and()
            .sessionManagement()
            .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
        .and()
            .authorizeRequests()
            .antMatchers("/api/profile-info").permitAll()
            .antMatchers("/api/**").authenticated()
            .antMatchers("/management/health").permitAll()
            .antMatchers("/management/logs").authenticated()
            .antMatchers("/management/**").hasAuthority(AuthoritiesConstants.ADMIN);
    }

    /**
     * OAuth2 resource server configuration (setJwtAccessTokenConverter is necessary).
     */

    @Override
    public void configure(ResourceServerSecurityConfigurer resources) throws Exception {
        // Set resourceId to NULL to ignore the JWT "aud" field.
        resources.resourceId(null);
    }
}
