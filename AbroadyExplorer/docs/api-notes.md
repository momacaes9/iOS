# API notes

Short reference for the two APIs Abroady Explorer uses. No keys in this file.

## REST Countries v5

- Base URL: `https://api.restcountries.com/countries/v5`
- Auth: every request needs the header `Authorization: Bearer <key>`. The key lives in `Secrets.swift` (gitignored).
  Without it the API answers `401` with `{"errors":[{"message":"Authorization key required.","code":"general.auth_key_missing"}]}`.
- Source for the shapes below: the public docs at https://restcountries.com/docs/countries (the sample record and list response).
  I couldn't call the API with a real key while building, because `Secrets.swift` didn't exist yet. The Codable models were checked
  by decoding the documented sample JSON.

### Endpoints we use

| What | Request |
|---|---|
| List all countries (paginated) | `GET /countries/v5?limit=100&offset=0` |
| Filter by region | `GET /countries/v5?region=Europe` |
| Free-text search | `GET /countries/v5?q=france` |
| Only some fields | `&response_fields=names.common,codes.alpha_2,...` |

- `limit` defaults to 25. The max is 100 on the free plan. There are about 249 countries, so the app makes 3 requests (offset 0, 100, 200).
- The app downloads everything once and does search, region filtering and sorting on the phone.

### Response wrapper

```json
{
  "data": {
    "objects": [ { ...country... } ],
    "meta": { "total": 249, "count": 100, "limit": 100, "offset": 0, "more": true }
  }
}
```

Keep paging while `meta.more` is `true`. Errors come back as `{"errors": [{"message": "...", "code": "..."}]}`.

### One country (only the fields we use)

```json
{
  "names": { "common": "Canada", "official": "Canada" },
  "codes": { "alpha_2": "CA", "alpha_3": "CAN" },
  "capitals": [{ "name": "Ottawa", "primary": true }],
  "flag": { "emoji": "🇨🇦", "url_png": "https://flags.restcountries.com/v5/w640/ca.png" },
  "region": "Americas",
  "subregion": "North America",
  "population": 38005238,
  "languages": [{ "name": "English", "bcp47": "en" }, { "name": "French", "bcp47": "fr" }],
  "currencies": [{ "code": "CAD", "name": "Canadian dollar", "symbol": "$" }]
}
```

Snake_case names (`alpha_2`, `url_png`) are mapped to camelCase with `CodingKeys`.
`capitals`, `currencies`, `languages`, `subregion` and `population` are optional in the models,
because some territories (like Antarctica) don't have them.

## Frankfurter (public, no key)

- `GET https://api.frankfurter.dev/v1/latest?base=USD`

```json
{ "amount": 1.0, "base": "USD", "date": "2026-11-12",
  "rates": { "EUR": 0.90245, "GBP": 0.7544, "JPY": 159.7, "...": 0 } }
```

- `GET https://api.frankfurter.dev/v1/currencies` lists the supported currencies. There are only 30 (European Central Bank data):
  AUD, BRL, CAD, CHF, CNY, CZK, DKK, EUR, GBP, HKD, HUF, IDR, ILS, INR, ISK, JPY, KRW, MXN, MYR, NOK, NZD, PHP, PLN, RON, SEK, SGD, THB, TRY, USD, ZAR.
- Many countries (for example Peru, Kenya, Vietnam) use currencies that aren't on this list, so the converter shows a friendly
  "not supported" message for them.
