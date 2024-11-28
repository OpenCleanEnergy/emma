using System.Security.Cryptography;
using System.Text;

namespace OpenEMS.Infrastructure.Integrations.Shared.Cryptography;

// https://cheatsheetseries.owasp.org/cheatsheets/DotNet_Security_Cheat_Sheet.html#encryption-for-storage
public class AesGcmEncryption(AesGcmEncryptionConfiguration configuration)
{
    private readonly AesGcmEncryptionConfiguration _configuration = configuration;

    public virtual AesGcmEncryptionResult Encrypt(string plaintext)
    {
        var key = _configuration.Key;
        var nonce = AesGcmNonce.Random();

        using var aes = new AesGcm(key.AsReadOnlySpan(), AesGcmTag.ByteSize);

        // Tag for authenticated encryption
        var tag = new byte[AesGcmTag.ByteSize];

        // Create a byte array from the message to encrypt
        var plaintextBytes = Encoding.UTF8.GetBytes(plaintext);

        // Cipher will be same length in bytes as plaintext
        var ciphertext = new byte[plaintextBytes.Length];

        // perform the actual encryption
        aes.Encrypt(nonce.AsReadOnlySpan(), plaintextBytes, ciphertext, tag);

        // Return the encrypted message
        return new AesGcmEncryptionResult(
            nonce,
            AesGcmCiphertext.From(ciphertext),
            AesGcmTag.From(tag)
        );
    }

    public virtual string Decrypt(AesGcmEncryptionResult encryptionResult)
    {
        var key = _configuration.Key;
        var nonce = encryptionResult.Nonce.AsReadOnlySpan();
        var ciphertext = encryptionResult.Ciphertext.AsReadOnlySpan();
        var tag = encryptionResult.Tag.AsReadOnlySpan();

        using var aes = new AesGcm(key.AsReadOnlySpan(), tag.Length);

        // Plaintext will be same length in bytes as cipher
        var plaintextBytes = new byte[ciphertext.Length];

        // perform the actual decryption
        aes.Decrypt(nonce: nonce, ciphertext: ciphertext, tag: tag, plaintext: plaintextBytes);

        return Encoding.UTF8.GetString(plaintextBytes);
    }
}
