using System.Net;
using System.Net.Http.Json;
using Microsoft.AspNetCore.Mvc;
using ProyectoComunas.Web.Models;

namespace ProyectoComunas.Web.Controllers;

public sealed class ComunaController(IHttpClientFactory httpClientFactory) : Controller
{
    public async Task<IActionResult> Index(
        int idRegion, CancellationToken cancellationToken)
    {
        var client = httpClientFactory.CreateClient("ApiClient");
        var comunas = await client.GetFromJsonAsync<List<Comuna>>(
            $"/api/region/{idRegion}/comuna", cancellationToken);
        return View(comunas ?? []);
    }

    [HttpGet]
    public async Task<IActionResult> Editar(
        int idRegion, int idComuna, CancellationToken cancellationToken)
    {
        var client = httpClientFactory.CreateClient("ApiClient");
        var response = await client.GetAsync(
            $"/api/region/{idRegion}/comuna/{idComuna}", cancellationToken);

        if (response.StatusCode == HttpStatusCode.NotFound)
            return NotFound();

        response.EnsureSuccessStatusCode();
        var comuna = await response.Content.ReadFromJsonAsync<Comuna>(
            cancellationToken);
        return comuna is null ? NotFound() : View(comuna);
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Editar(
        Comuna comuna, CancellationToken cancellationToken)
    {
        if (!ModelState.IsValid)
            return View(comuna);

        var client = httpClientFactory.CreateClient("ApiClient");
        var response = await client.PostAsJsonAsync(
            $"/api/region/{comuna.IdRegion}/comuna", comuna, cancellationToken);

        if (!response.IsSuccessStatusCode)
        {
            ModelState.AddModelError(string.Empty, "No fue posible actualizar la comuna.");
            return View(comuna);
        }

        TempData["Mensaje"] = "Comuna actualizada correctamente.";
        return RedirectToAction(nameof(Index), new { idRegion = comuna.IdRegion });
    }
}
