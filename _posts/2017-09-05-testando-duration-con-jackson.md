---
layout: post
tags: java
---
Que buen título. Digamos que estás programando con `java`, estas creando tu bonita __API REST__, y llega un momento
en el que quieres testear un endpoint. Ese endpoint es `POST/PUT`, y espera recibir, por ejemplo, la duración en minutos
de una película.

Dependiendo del framework usado (en este caso [Dropwizard](http://www.dropwizard.io/)) e historias varias,
el codigo variará muchísimo, pero pongamos que tenemos algo así:
```java
@PUT
@Timed
@UnitOfWork
@Path("/update/movie")
public Response updateDuration(
  @Valid final MovieUpdateParam updateParam
) {
  ...
}
```
```java
public class MovieUpdateParam {
  @NotNull
  private final Long durationMinutes;

  @JsonCreator
  public MovieUpdateParam(
    @JsonProperty("durationMinutes") final Long durationMinutes,
  ) {
    this.durationMinutes = durationMinutes;
  }

  public Duration getDurationMinutes() {
    return Duration.ofMinutes(duration);
  }
}
```

Entonces, para testearlo, algo como:
```java
@Test
public void testMovieUpdateParam() {
  final MovieUpdateParam param = new MovieUpdateParam(
    Duration.ofMinutes(90L)
  );
  final Entity<MovieUpdateParam> entity = Entity.json(param);
  final Response response = ResourceTestRule.client()
    .target("/update/schedule")
    .request(MediaType.APPLICATION_JSON)
    .put(entity);

  assertThat(response.getStatus()).isEqualTo(Response.Status.OK.getStatusCode());
}
```

Buceando en el código (gracias debugger, gracias `java`), llegamos a estas líneas de `Jackson`:
```java
public void serialize(Duration duration, JsonGenerator generator, SerializerProvider provider) throws IOException {
  if (this.useTimestamp(provider)) {
    if (provider.isEnabled(SerializationFeature.WRITE_DATE_TIMESTAMPS_AS_NANOSECONDS)) {
      generator.writeNumber(DecimalUtils.toBigDecimal(duration.getSeconds(), duration.getNano()));
    } else {
      generator.writeNumber(duration.toMillis());
    }
  } else {
      generator.writeString(duration.toString());
  }
}
```

Pues ahí lo tienes, esto es lo que va a pasar:
1. En el test creamos una instancia de `MovieUpdateParam`, pasándole una duración de 90 minutos.
2. El test debe serializar esa instancia en `JSON` para hacer un request al endpoint, para ello utiliza `Jackson`.
3. Esperamos que genere esto: `{ "durationMinutes": 90 }`, el problema es que para serializar ese `90`,
como es un `Duration` (el de la instancia del punto 1), `Jackson` va a utilizar por defecto su método `serialize` de arriba.
4. Eso provoca que un `Duration.ofMinutes(90L)` se serialice usando `duration.getSeconds()`, lo que genera
un `JSON` tal que así: `{ "durationMinutes": 5400 }`.
5. Eso es lo que va a recibir el endpoint, acabando con un `Duration.ofMinutes(5400L)`, por lo tanto
lo que sea que queramos testear fallará.

Es un jaleo, lo sé. Resumiendo ¿cómo se soluciona el entuerto? pues con la anotación `@JsonSerialize`, que permite
especificar una clase para serializar una propiedad en vez de utilizar el método por defecto de `Jackson`:
```java
public class MovieUpdateParam {
  @NotNull
  private final Long durationMinutes;

  @JsonCreator
  public MovieUpdateParam(
    @JsonProperty("durationMinutes") final Long durationMinutes,
  ) {
    this.durationMinutes = durationMinutes;
  }

  @JsonSerialize(using = DurationSerializer.class)
  public Duration getDurationMinutes() {
    return Duration.ofMinutes(duration);
  }
}

class DurationSerializer extends JsonSerializer<Duration> {
  @Override
  public void serialize(final Duration value, final JsonGenerator generator, final SerializerProvider provider) throws IOException {
    generator.writeNumber(value.toMinutes());
  }
}
```
