package br.com.helpiguacu.backend.infrastructure.security

import org.springframework.boot.context.properties.ConfigurationProperties
import org.springframework.context.annotation.Configuration

@Configuration
@ConfigurationProperties("app.jwt")
class JwtProperties {
    lateinit var secret: String
}