package br.com.helpiguacu.backend.resource.donation

import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import io.swagger.v3.oas.annotations.media.Schema
import java.time.LocalDateTime

@JsonIgnoreProperties(ignoreUnknown = true)
@Schema(description = "Authentication response representation")
data class DonationRepresentation (
    @field:Schema(description = "User identifier")
    val id: Long?,

    @field:Schema(description = "Name")
    val title: String,

    @field:Schema(description = "Description")
    val description: String,

    @field:Schema(description = "Donor ID")
    val donorId: Long,

    @field:Schema(description = "Status")
    val status: String,

    @field:Schema(description = "Items")
    val items: List<DonationItemRepresentation>,

    @field:Schema(description = "Creation date")
    val createdAt: LocalDateTime?,

    @field:Schema(description = "Last update date")
    val updatedAt: LocalDateTime?
)