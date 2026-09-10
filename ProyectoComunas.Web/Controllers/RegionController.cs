using System.Net.Http.Json;
using Microsoft.AspNetCore.Mvc;
using ProyectoComunas.Web.Models;

namespace ProyectoComunas.Web.Controllers;

public sealed class RegionController(IHttpClientFactory httpClientFactory) : Controller
{
    public async Task<IActionResult> Index(CancellationToken cancellationToken)
    {
        var client = httpClientFactory.CreateClient("ApiClient");
        var regiones = await client.GetFromJsonAsync<List<Region>>(
            "/api/region", cancellationToken);
        return View(regiones ?? []);
    }
}
