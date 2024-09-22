using System.Security.Cryptography;
using JWT.Algorithms;
using JWT.Builder;
using JWT.Exceptions;
using OpenEMS.Application.Shared.Logging;

namespace OpenEMS.Integrations.Shelly.Application.Callback;

/// <summary>
/// See https://shelly-api-docs.shelly.cloud/integrator-api/users#callback-url-security.
/// </summary>
public class ShellyTrustTokenValidator
{
    private const string PublicKey = """
        -----BEGIN PUBLIC KEY-----
        MHYwEAYHKoZIzj0CAQYFK4EEACIDYgAE3Kx+6C/0ZbnelYUgucUo4/X4xt1NCmEL
        coyLpgkuLHume4VLZnQjtXeYgzr2FUdsO/ip8SzssSu3CEU9ArvB+yGIlW7l1yLt
        wHVs/2zXrL0riL++7jdoQCpTGanFVzpM
        -----END PUBLIC KEY-----
        """;

    private readonly ILogger _logger;
    private JwtBuilder? _cachedJwtBuilder;

    public ShellyTrustTokenValidator(ILogger<ShellyTrustTokenValidator> logger)
    {
        _logger = logger;
    }

    public virtual bool Validate(string? token)
    {
        if (string.IsNullOrEmpty(token))
        {
            _logger.Warning("Token is null or empty.");
            return false;
        }

        try
        {
            var builder = GetJwtBuilder();
            var json = builder.Decode(token);
            _logger.Debug("Valid {Token}", json);
            return true;
        }
        catch (TokenNotYetValidException)
        {
            _logger.Warning("Token is not valid yet.");
        }
        catch (TokenExpiredException)
        {
            _logger.Warning("Token has expired");
        }
        catch (SignatureVerificationException)
        {
            _logger.Warning("Token has invalid signature");
        }
        catch (Exception exception)
        {
            _logger.Critical(exception, "Unexpected exception.");
        }

        return false;
    }

    private JwtBuilder GetJwtBuilder()
    {
        if (_cachedJwtBuilder is not null)
        {
            return _cachedJwtBuilder;
        }

        var publicKey = ECDsa.Create();
        publicKey.ImportFromPem(PublicKey);

        _cachedJwtBuilder = JwtBuilder
            .Create()
            .MustVerifySignature()
            .WithAlgorithm(new ES384Algorithm(publicKey));

        return _cachedJwtBuilder;
    }
}
