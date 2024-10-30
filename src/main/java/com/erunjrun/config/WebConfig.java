package com.erunjrun.config;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.support.ErrorPageFilter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class WebConfig {
	 @Bean
    public FilterRegistrationBean<ErrorPageFilter> disableErrorPageFilter(ErrorPageFilter filter) {
        FilterRegistrationBean<ErrorPageFilter> registrationBean = new FilterRegistrationBean<>(filter);
        registrationBean.setEnabled(false);  // ErrorPageFilter 비활성화
        return registrationBean;
    }
}
