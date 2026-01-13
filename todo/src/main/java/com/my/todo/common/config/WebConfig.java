package com.my.todo.common.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/api/**")
                        .allowedOriginPatterns("http://localhost:*","http://10.0.2.2:*")
                        .allowCredentials(true)
                        .allowedMethods("GET","POST","PUT","DELETE","PATCH","OPTIONS")
                        .allowedHeaders("*");
            }
        };
    }
}

/*
When allowCredentials is true,
allowedOrigins cannot contain the special value "*" since that cannot be set on the
"Access-Control-Allow-Origin" response header.
To allow credentials to a set of origins, list them explicitly or consider using
"allowedOriginPatterns" instead.


1. controller 파일에
@CrossOrigin(origins = "*") 이 존재하면 충돌 발생

@CrossOrigin 내부는 allowedOrigin 형태로 특정 주소값들만 받을 수 있도록 되어있으며,
                    .allowCredentials(true) false 형태로 되어 있음

개발자가 WebConfig 라는 웹 설정 파일을 만들며, .allowCredentials(true)로 설정했기 때문에
.allowedOrigin(*) 와 .allowCredentials(true)가 만나 충돌 발생

언젠가는 프로그램이 제대로 동작, 언젠가는 프로그램에서 위와 같은 에러 발생

언제 잘 되고, 언제 안되는지 알 수 없으며, 웹설정의 경우 개발자나 회사 요구하는 사항으로
코드를 작성하는 것이 바람직하기 때문에
@CrossOrigin 사용을 지양
 */