# DE Words Analysis

Data source: [link](https://www.korrekturen.de/flexion/download/)

Data description can be found [here](https://morphy.wolfganglezius.de/content/2-download/wklassen.pdf)

## Requirements

- [GNU make](https://www.gnu.org/software/make/)

- [curl](https://linux.die.net/man/1/curl)

- [docker](https://www.docker.com/)

## Verbs

- What is the fraction of irregular verbs?

|cnt_all|cnt_irregular|
|-|-|
|6634|2915|

See the logic [here](./z_calc.sql).

## How to run

First time setup:

```bash
make setup
```

To download the dictionar(y/is):

```bash
make download
```

To connect to db and run queries:

```bash
make connect
```

## References

- [Data](https://github.com/languagetool-org/german-pos-dict)

## License

- [Data](https://creativecommons.org/licenses/by-sa/4.0/)
