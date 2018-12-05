package com.onceforall.pdfgenerator.security;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.security.oauth2.provider.OAuth2Request;
import org.springframework.security.oauth2.provider.token.DefaultAccessTokenConverter;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Custom access converter
 */
public class CustomAccessTokenConverter extends DefaultAccessTokenConverter {

    @Override
    public OAuth2Authentication extractAuthentication(Map<String, ?> map) {
        OAuth2Authentication parentAuthentication = super.extractAuthentication(map);
        OAuth2Request parentOAuth2Request = parentAuthentication.getOAuth2Request();

        List<String> realmAccessAuthoritiesAsString = extractRealmAuthoritiesAsString(map);
        List<String> resourceAccessAuthoritiesAsString = extractResourceAccessAuthoritiesAsString(map);

        List<String> authoritiesAsString = new ArrayList<>();
        authoritiesAsString.addAll(realmAccessAuthoritiesAsString);
        authoritiesAsString.addAll(resourceAccessAuthoritiesAsString);

        Collection<? extends GrantedAuthority> authorities;
        authorities = AuthorityUtils.createAuthorityList(authoritiesAsString.toArray(new String[authoritiesAsString.size()]));

        OAuth2Request oAuth2Request = new OAuth2Request(
            parentOAuth2Request.getRequestParameters(),
            parentOAuth2Request.getClientId(),
            authorities,
            parentOAuth2Request.isApproved(),
            parentOAuth2Request.getScope(),
            parentOAuth2Request.getResourceIds(),
            parentOAuth2Request.getRedirectUri(),
            parentOAuth2Request.getResponseTypes(),
            parentOAuth2Request.getExtensions()
        );

        OAuth2Authentication oAuth2Authentication = new OAuth2Authentication(oAuth2Request, parentAuthentication.getUserAuthentication());
        oAuth2Authentication.setDetails(map);
        return oAuth2Authentication;
    }

    public List<String> extractRealmAuthoritiesAsString(Map<String, ?> map) {
        return map.entrySet().stream()
            .filter(entry -> "realm_access".equals(entry.getKey()))
            .flatMap(realmAccessEntry -> ((Map.Entry<String, Map<String, List<String>>>) realmAccessEntry).getValue().get("roles").stream())
            .collect(Collectors.toList());
    }

    public List<String> extractResourceAccessAuthoritiesAsString(Map<String, ?> map) {
        return map.entrySet().stream()
            .filter(entry -> "resource_access".equals(entry.getKey()))
            .flatMap(resourceAccessEntry -> ((Map.Entry<String, Map<String, Map<String, List<String>>>>) resourceAccessEntry).getValue().entrySet().stream()
                .flatMap(applicationEntry -> applicationEntry.getValue().get("roles").stream()
                    .map(applicationRole -> applicationEntry.getKey() + ":" + applicationRole)
                )
            )
            .collect(Collectors.toList());
    }
}
