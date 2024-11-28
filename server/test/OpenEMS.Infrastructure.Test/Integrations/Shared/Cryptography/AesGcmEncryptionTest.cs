using FluentAssertions;
using OpenEMS.Infrastructure.Integrations.Shared.Cryptography;

namespace OpenEMS.Infrastructure.Test.Integrations.Shared.Cryptography;

public class AesGcmEncryptionTest
{
    [Fact]
    public void Encrypts_And_Decrypts_Plaintext()
    {
        // Arrange
        var configuration = new AesGcmEncryptionConfiguration
        {
            Key = AesGcmKey.From("256-bit key for AES encryption__"),
        };

        var sut = new AesGcmEncryption(configuration);
        var plaintext = "Hello, World!";

        // Act
        var encryptionResult = sut.Encrypt(plaintext);
        var decryptedPlaintext = sut.Decrypt(encryptionResult);

        // Assert
        encryptionResult.Ciphertext.Value.Should().NotBeNullOrEmpty();
        decryptedPlaintext.Should().Be(plaintext);
    }
}
