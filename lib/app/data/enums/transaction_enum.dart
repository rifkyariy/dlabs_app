enum TRANSACTIONSTATUS {
  newTransaction,
  confirmed,
  inProgress,
  readyToLab,
  resultVerification,
  canceled,
  done,
  readyToSample,
  paymentRejected,
  partiallyToSample,
  partiallyToLab,
  labProcess,
  readyToRelease,
  partiallyDone
}

enum TRANSACTIONTYPE { organization, personal }
