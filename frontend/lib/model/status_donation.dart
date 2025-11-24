enum StatusDonation {
  PENDENTE_COLETA,
  COLETADA,
  EM_TRANSPORTE,
  FINALIZADA;

  static StatusDonation fromString(String value) {
    return StatusDonation.values.firstWhere(
          (e) => e.name == value,
      orElse: () => StatusDonation.PENDENTE_COLETA,
    );
  }
}
