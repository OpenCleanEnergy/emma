namespace OpenEMS.Infrastructure.Integrations.Shared.Cryptography;

public record AesGcmEncryptionResult(AesGcmNonce Nonce, AesGcmCiphertext Ciphertext, AesGcmTag Tag);
