
### Using Parquet File

- Download the Parquet file from Azure Storage Account (e.g. part-00000-dcccd45e-970a-46dc-89e8-ba86c1783c30-c000.snappy.parquet )
- Navigate to folder of downloaded file.
- Run spark-shell

```
spark-shell
```

### From Spark shell

Load the File; Register Table; Query; and Display

```
val sqlContext = new org.apache.spark.sql.SQLContext(sc)

val parqfile = sqlContext.read.parquet("part-00000-dcccd45e-970a-46dc-89e8-ba86c1783c30-c000.snappy.parquet")

parqfile.registerTempTable("data")

val allrecords = sqlContext.sql("SELECT * FROM data")

allrecords.show()
```


### Loading a Specifc id

```
val somerecords = sqlContext.sql("SELeCT * FROM data where id = 113163")
somerecords.show()
```

### Gettting Count

```
val count = sqlContext.sql("select count(*) from data")
count.show
count.collect.foreach(println)
```
