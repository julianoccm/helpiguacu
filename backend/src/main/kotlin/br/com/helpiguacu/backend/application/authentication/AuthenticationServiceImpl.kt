package br.com.helpiguacu.backend.application.authentication

import br.com.helpiguacu.backend.domain.exception.AuthenticationException
import br.com.helpiguacu.backend.domain.model.authentication.AuthenticationService
import br.com.helpiguacu.backend.infrastructure.persistence.user.UserRepository
import br.com.helpiguacu.backend.infrastructure.security.JwtUtils
import br.com.helpiguacu.backend.resource.authentication.AuthenticationResponseRepresentation
import br.com.helpiguacu.backend.resource.authentication.toRepresentation
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.Authentication
import org.springframework.security.core.GrantedAuthority
import org.springframework.security.core.userdetails.User
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.stereotype.Service

@Service
class AuthenticationServiceImpl(
    private val userRepository: UserRepository,
    private val jwtUtils: JwtUtils,
    private val passwordEncoder: PasswordEncoder
): AuthenticationService {

    override fun login(username: String, password: String): AuthenticationResponseRepresentation {
        val user = userRepository.findByEmail(username)
            ?: throw AuthenticationException("User not found!")

        if (!passwordEncoder.matches(password, user.password)) {
            throw AuthenticationException("Invalid password!")
        }

        val token = jwtUtils.generateToken(user.email)
        return AuthenticationResponseRepresentation(token, user.toRepresentation())
    }

    override fun getAuthentication(username: String): Authentication {
        val user = userRepository.findByEmail(username)
            ?: throw AuthenticationException("User not found!")

        val authorities = emptyList<GrantedAuthority>()
        val principal = User(user.email, user.password, authorities)

        return UsernamePasswordAuthenticationToken(principal, null, authorities)
    }
}