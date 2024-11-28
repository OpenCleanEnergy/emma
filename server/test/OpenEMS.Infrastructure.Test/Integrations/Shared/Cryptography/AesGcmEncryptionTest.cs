using FluentAssertions;
using OpenEMS.Infrastructure.Integrations.Shared.Cryptography;

namespace OpenEMS.Infrastructure.Test.Integrations.Shared.Cryptography;

public class AesGcmEncryptionTest
{
    [Fact]
    public void Encrypts_And_Decrypts_Plaintext()
    {
        // Arrange
        // openssl rand -base64 32
        var base64Key = "AFKLAp6byz5N76XCivyM3qZyYurEBA2eBLMO5Xv20ns=";
        var configuration = new AesGcmEncryptionConfiguration { Key = AesGcmKey.From(base64Key) };

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
