package br.com.helpiguacu.backend.application.authentication

import br.com.helpiguacu.backend.resource.authentication.AuthenticationResponseRepresentation
import br.com.helpiguacu.backend.resource.authentication.UserRepresentation
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.junit5.MockKExtension
import io.mockk.mockk
import io.mockk.verify
import org.junit.jupiter.api.Assertions.assertSame
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith
import org.springframework.security.core.Authentication


@ExtendWith(MockKExtension::class)
class AuthenticationFacadeImplTest {

    @MockK
    lateinit var authenticationService: AuthenticationServiceImpl

    @Test
    fun `login delegates to authentication service and returns response`() {
        val facade = AuthenticationFacadeImpl(authenticationService)
        val username = "user@example.com"
        val password = "secret"
        val expectedResponse = mockk<AuthenticationResponseRepresentation>()

        every { authenticationService.login(username, password) } returns expectedResponse

        val actual = facade.login(username, password)

        assertSame(expectedResponse, actual)
        verify { authenticationService.login(username, password) }
    }

    @Test
    fun `getAuthentication delegates to authentication service and returns authentication`() {
        val facade = AuthenticationFacadeImpl(authenticationService)
        val username = "user@example.com"
        val expectedAuth = mockk<Authentication>()

        every { authenticationService.getAuthentication(username) } returns expectedAuth

        val actual = facade.getAuthentication(username)

        assertSame(expectedAuth, actual)
        verify { authenticationService.getAuthentication(username) }
    }

    @Test
    fun `register delegates to authentication service and returns user representation`() {
        val facade = AuthenticationFacadeImpl(authenticationService)
        val request = mockk<UserRepresentation>()
        val expected = mockk<UserRepresentation>()

        every { authenticationService.register(request) } returns expected

        val actual = facade.register(request)

        assertSame(expected, actual)
        verify { authenticationService.register(request) }
    }
}