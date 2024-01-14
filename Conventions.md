
### To refresh widget:

any table extending LocalTable may use listenTable

```dart
ValueListenableBuilder<Box<OutboundLdvDetail>>(
      valueListenable: OutboundLdvDetail().listenTable,
      builder: (context, obox, widget) {
        // filter ?
        var buffer = obox.values
            .toList();

        if (buffer.isEmpty) return 'Empty Data'.text.make();

        return buffer.mapIndexed((p, idx) => onRender(p)).toList().column();
      })
```



