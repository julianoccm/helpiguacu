package br.com.helpiguacu.backend.domain.model.authentication

import br.com.helpiguacu.backend.resource.authentication.AuthenticationResponseRepresentation
import org.springframework.security.core.Authentication

interface AuthenticationFacade {
    fun login(username: String, password: String): AuthenticationResponseRepresentation
    fun getAuthentication(username: String): Authentication
}