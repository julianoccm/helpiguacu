package br.com.helpiguacu.backend.resource.authentication

import br.com.helpiguacu.backend.infrastructure.persistence.user.User

fun User.toRepresentation(): UserRepresentation {
    return UserRepresentation(
        id = this.id,
        name = this.name,
        cpf = this.cpf,
        email = this.email,
        password = this.password,
        cep = this.cep,
        addresNumber = this.addresNumber,
        addresComplement = this.addresComplement
    )
}
