package br.com.helpiguacu.backend.application.authentication

import br.com.helpiguacu.backend.domain.model.authentication.AuthenticationFacade
import br.com.helpiguacu.backend.resource.authentication.AuthenticationResponseRepresentation
import org.springframework.security.core.Authentication
import org.springframework.stereotype.Service

@Service
class AuthenticationFacadeImpl(
    private val authenticationService: AuthenticationServiceImpl,
): AuthenticationFacade {

    override fun login(username: String, password: String): AuthenticationResponseRepresentation {
        return authenticationService.login(username, password)
    }

    override fun getAuthentication(username: String): Authentication {
        return authenticationService.getAuthentication(username)
    }
}