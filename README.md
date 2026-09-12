# hugo-datatable

## Usage

Let's assume you have the following data file (YAML):

```yaml
# pets.yaml
- name: Fluffy
  category: Dog
  tags: [friendly]
- name: Tiger
  category: Cat
  tags: [cute, indoor]
```

You could use the `datatable` shortcode like this:

```gotmpl
{{< datatable file="pets.yaml" headers="Category,Name,Tags" >}}
<td><em>{{ .category }}</em></td>
<td>{{ .name | upper }}</td>
<td>{{ delimit .tags " / " }}</td>
{{< /datatable >}}
```

And it would render as:

<details>
  <summary><i>(click to view source)</i>
    <table>
      <thead>
        <tr>
          <th>Category</th>
          <th>Name</th>
          <th>Tags</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><em>Dog</em></td>
          <td>FLUFFY</td>
          <td>friendly</td>
        </tr>
        <tr>
          <td><em>Cat</em></td>
          <td>TIGER</td>
          <td>cute / indoor</td>
        </tr>
      </tbody>
    </table>
  </summary>

```html
<table>
  <thead>
    <tr>
      <th>Category</th>
      <th>Name</th>
      <th>Tags</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><em>Dog</em></td>
      <td>FLUFFY</td>
      <td>friendly</td>
    </tr>
    <tr>
      <td><em>Cat</em></td>
      <td>TIGER</td>
      <td>cute / indoor</td>
    </tr>
  </tbody>
</table>
```

</details>

## Reference

### `file` parameter

The YAML file that is read from either
[page resources](https://gohugo.io/quick-reference/glossary/#page-resource) or
[global resources](https://gohugo.io/quick-reference/glossary/#global-resource).

#### Page resources

Assuming your project looks something like this:

```
content
└── posts
    ├── first-post
    │   ├── index.md
    │   └── first.yaml
    └── second-post
        ├── index.md
        └── second.yaml
```

Within `first-post/index.md`, you could write the following:

```gotmpl
{{< datatable file="first.yaml" >}}
```

Referencing a resource from another page bundle (for example `second.yaml`)
would **not** work.

#### Global resources

You can always reference files from global resources. For example, the file
`assets/some-data.yaml` can be referenced just so:

```gotmpl
{{< datatable file="some-data.yaml" >}}
```

### `type` parameter

Hugo has fairly robust detection of a resource's file type:

- For each
  [supported format](https://gohugo.io/functions/transform/unmarshal/#format),
  the homonymous file extension (plus `.yml` for YAML).
- When using [`datatable-data`](#datatable-data-shortcode), mimesniffing based
  on the first 512 bytes of content
  ([Go's `net/http.DetectContentType`](https://pkg.go.dev/net/http#DetectContentType)).

The `type` parameter overrides any automated detection:

```gotmpl
{{< datatable file="dump.txt" type="csv" >}}
```

### `headers` parameter

The table headers (`<th>` in `<thead>`) are determined from the `headers`
parameter, which is a comma-separated string of literal values:

```gotmpl
{{< datatable headers="A,B,C" >}}
```

Result:

```html
<thead>
  <tr>
    <th>A</th>
    <th>B</th>
    <th>C</th>
  </tr>
</thead>
```

There is no escaping, Markdown parsing, or other post-processing of these
values.

### `class` parameter

By default, the shortcode generates a bare table:

```html
<table>
  ...
</table>
```

By passing the `class` parameter, you can set one or more CSS classes:

```gotmpl
{{< datatable class="striped sticky-header" >}}
```

Result:

```html
<table class="striped sticky-header">
  ...
</table>
```

### `root` parameter

Sometimes you don't control the layout of your input; or, in the case of formats
like TOML, there are simply no top-level arrays to iterate through:

```toml
[home]
  [[home.pets]]
    name = "Fluffy"
  [[home.pets]]
    name = "Tiger"
```

```json
{
  home: {
    pets: [  # << This is an array we can loop over.
      {name: "Fluffy"},
      {name: "Tiger"},
    ],
  },
}
```

For these cases, you can set the root to be a nested element:

```gotmpl
{{< datatable root="home.pets" >}}
```

### `datatable-head` shortcode

By default, the [`headers` parameter](#headers-parameter) determines the
contents of `<thead>`. The `datatable-head` shortcode allows overriding that:

```gotmpl
{{< datatable-head >}}
<th colspan=2>Name (category)</th>
<th>Tags</th>
{{< /datatable-head >}}

{{< datatable file="pets.yaml" >}}
<td>{{ .name }}</td>
<td>{{ .category }}</td>
<td>{{ delim .tags " / " }}</td>
{{< /datatable >}}
```

Result:

<details>
  <summary><i>(click to view source)</i>
    <table>
      <thead>
        <tr>
          <th colspan=2>Name (category)</th>
          <th>Tags</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>Fluffy</td>
          <td>Dog</td>
          <td>friendly</td>
        </tr>
        <tr>
          <td>Tiger</td>
          <td>Cat</td>
          <td>cute / indoor</td>
        </tr>
      </tbody>
    </table>
  </summary>

```html
<table>
  <thead>
    <tr>
      <th colspan=2>Name (category)</th>
      <th>Tags</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Fluffy</td>
      <td>Dog</td>
      <td>friendly</td>
    </tr>
    <tr>
      <td>Tiger</td>
      <td>Cat</td>
      <td>cute / indoor</td>
    </tr>
  </tbody>
</table>
```

</details>

### `datatable-data` shortcode

By default, the [`file` parameter](#file-parameter) determines which resource to
read the table data from. Resource files can be inconvenient, though, e.g. when
acting inside a leaf page (not a page bundle.) The `datatable-data` shortcode
allows inlining that:

```gotmpl
{{< datatable-data >}}
- category: Hamster
  name: Ginger
  tags: []
- category: Octopus
  name: Cthulhu
  tags: [slimy]
{{< /datatable-data >}}

{{< datatable headers="Monsters" >}}
<td>{{ .name }}, the {{ delim .tags " " }} {{ .category }}</td>
{{< datatable >}}
```

Result:

<details>
  <summary><i>(click to view source)</i>
    <table class="striped sticky-header">
      <thead>
        <tr>
          <th>Monsters</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>Ginger, the Hamster</td>
        </tr>
        <tr>
          <td>Cthulhu, the slimy Octopus</td>
        </tr>
      </tbody>
    </table>
  </summary>

```html
<table class="striped sticky-header">
  <thead>
    <tr>
      <th>Monsters</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Ginger, the Hamster</td>
    </tr>
    <tr>
      <td>Cthulhu, the slimy Octopus</td>
    </tr>
  </tbody>
</table>
```

</details>

## Related

[Hugo's documentation itself](https://gohugo.io/content-management/data-sources/#augment-existing-content)
proposes a `csv-to-table` shortcode which produces a table based on a CSV
resource. However, the shortcode hard-codes a row layout (usually one `<td>` per
CSV column); writers would have to modify their shortcode to support an
ever-growing list of features, or create one fork per CSV layout.
