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
<td><em>{{ .Category }}</em></td>
<td>{{ .Name | upper }}</td>
<td>{{ delimit .Tags " / " }}</td>
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
