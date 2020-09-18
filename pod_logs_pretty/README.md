
## Pods Logs

```
kubectl -n a4iot-khl0ljiipentakuw-items logs rats-1119aa2aa1ae41a9943f9f19780edb8e-5d549c4fc6-l54ch
```

Returns stack traces.  It's very hard to read. 

```
[2020-09-18 14:20:40.559] [WARN] [com.esri.realtime.core.execution.ContextHolder$] [2020-09-18T14:20:40.559Z] [com.esri.realtime.core.execution.ContextHolder$] [unknown] [null] [null] [khl0ljiipentakuw] [1119aa2aa1ae41a9943f9f19780edb8e] [raspmulti1] [admin] [{0} is not set in current context. WARNING returning null] ["metricsReporter"] metricsReporter is not set in current context. WARNING returning null :::LF:::
[2020-09-18 14:20:42.124] [WARN] [com.esri.realtime.io.output.arcgis.CreateFeatureLayerForKafkaStreams] [2020-09-18T14:20:42.124Z] [com.esri.realtime.io.output.arcgis.CreateFeatureLayerForKafkaStreams] [unknown] [null] [null] [khl0ljiipentakuw] [1119aa2aa1ae41a9943f9f19780edb8e] [raspmulti1] [user] [VALIDATION_OUTPUT_FEAT_LYR_NEW__INVALID_DATASET_NO_REPLACE] [] An issue was identified with this output dataset. Please save your analytic changes and refresh your browser tab. If this message is still encountered, please contact Esri Support for assistance or delete and recreate this output. :::LF:::
[2020-09-18 14:20:42.432] [WARN] [com.esri.realtime.io.output.arcgis.CreateFeatureLayerForKafkaStreams] [2020-09-18T14:20:42.432Z] [com.esri.realtime.io.output.arcgis.CreateFeatureLayerForKafkaStreams] [unknown] [null] [null] [khl0ljiipentakuw] [1119aa2aa1ae41a9943f9f19780edb8e] [raspmulti1] [user] [VALIDATION_OUTPUT_FEAT_LYR_NEW__INVALID_DATASET_NO_REPLACE] [] An issue was identified with this output dataset. Please save your analytic changes and refresh your browser tab. If this message is still encountered, please contact Esri Support for assistance or delete and recreate this output. :::LF:::
[2020-09-18 14:20:42.807] [ERROR] [com.esri.realtime.processing.RealTimeAnalyticTaskExecutor$] [2020-09-18T14:20:42.807Z] [com.esri.realtime.processing.RealTimeAnalyticTaskExecutor$] [output] [feat-lyr-new] [BAT_SOAK_RAT_Output_KeepLatestFeatures-2639] [khl0ljiipentakuw] [1119aa2aa1ae41a9943f9f19780edb8e] [raspmulti1] [user] [RATS__EXECUTOR__CATCH_ALL_FAILURE] ["1119aa2aa1ae41a9943f9f19780edb8e"] Real time analytic id: 1119aa2aa1ae41a9943f9f19780edb8e execution failed. :::LF:::
[2020-09-18 14:20:42.807] [ERROR] [com.esri.realtime.processing.RealTimeAnalyticTaskExecutor$] [2020-09-18T14:20:42.807Z] [com.esri.realtime.processing.RealTimeAnalyticTaskExecutor$] [output] [feat-lyr-new] [BAT_SOAK_RAT_Output_KeepLatestFeatures-2639] [khl0ljiipentakuw] [1119aa2aa1ae41a9943f9f19780edb8e] [raspmulti1] [admin] [RATS__EXECUTOR__CATCH_ALL_FAILURE] ["1119aa2aa1ae41a9943f9f19780edb8e"] Real time analytic id: 1119aa2aa1ae41a9943f9f19780edb8e execution failed. :::LF::: com.esri.realtime.processing.ProcessingStageExecutionException: java.lang.NullPointerException:::LF:::	at com.esri.realtime.processing.RealTimeAnalyticTaskExecutor$.delayedEndpoint$com$esri$realtime$processing$RealTimeAnalyticTaskExecutor$1(RealTimeAnalyticTaskExecutor.scala:139):::LF:::	at com.esri.realtime.processing.RealTimeAnalyticTaskExecutor$delayedInit$body.apply(RealTimeAnalyticTaskExecutor.scala:27):::LF:::	at scala.Function0$class.apply$mcV$sp(Function0.scala:34):::LF:::	at scala.runtime.AbstractFunction0.apply$mcV$sp(AbstractFunction0.scala:12):::LF:::	at scala.App$$anonfun$main$1.apply(App.scala:76):::LF:::	at scala.App$$anonfun$main$1.apply(App.scala:76):::LF:::	at scala.collection.immutable.List.foreach(List.scala:392):::LF:::	at scala.collection.generic.TraversableForwarder$class.foreach(TraversableForwarder.scala:35):::LF:::	at scala.App$class.main(App.scala:76):::LF:::	at com.esri.realtime.processing.RealTimeAnalyticTaskExecutor$.main(RealTimeAnalyticTaskExecutor.scala:27):::LF:::	at com.esri.realtime.processing.RealTimeAnalyticTaskExecutor.main(RealTimeAnalyticTaskExecutor.scala):::LF:::Caused by: java.lang.NullPointerException:::LF:::	at com.esri.realtime.io.output.arcgis.BDSUtil$.createServiceDefinitionJson(BDSUtil.scala:194):::LF:::	at com.esri.realtime.io.output.arcgis.BDSUtil$.publishServices(BDSUtil.scala:156):::LF:::	at com.esri.realtime.io.output.arcgis.CreateFeatureLayerForKafkaStreams.beforeExecute(CreateFeatureLayerForKafkaStreams.scala:95):::LF:::	at com.esri.realtime.processing.PipelineExecutorForKafkaStreamsImpl$$anonfun$beforeExecute$1.apply(PipelineExecutorForKafkaStreams.scala:85):::LF:::	at com.esri.realtime.processing.PipelineExecutorForKafkaStreamsImpl$$anonfun$beforeExecute$1.apply(PipelineExecutorForKafkaStreams.scala:82):::LF:::	at scala.collection.mutable.HashMap$$anon$2$$anonfun$foreach$3.apply(HashMap.scala:139):::LF:::	at scala.collection.mutable.HashMap$$anon$2$$anonfun$foreach$3.apply(HashMap.scala:139):::LF:::	at scala.collection.mutable.HashTable$class.foreachEntry(HashTable.scala:236):::LF:::	at scala.collection.mutable.HashMap.foreachEntry(HashMap.scala:40):::LF:::	at scala.collection.mutable.HashMap$$anon$2.foreach(HashMap.scala:139):::LF:::	at com.esri.realtime.processing.PipelineExecutorForKafkaStreamsImpl.beforeExecute(PipelineExecutorForKafkaStreams.scala:82):::LF:::	at com.esri.realtime.processing.PipelineTask$class.start(PipelineTask.scala:38):::LF:::	at com.esri.realtime.processing.RealTimeAnalyticTaskForKafkaStreams.start(RealTimeAnalyticTask.scala:82):::LF:::	at com.esri.realtime.processing.RealTimeAnalyticTaskExecutor$.delayedEndpoint$com$esri$realtime$processing$RealTimeAnalyticTaskExecutor$1(RealTimeAnalyticTaskExecutor.scala:121):::LF:::	... 10 more
```

### Pretty it up

```
kubectl -n a4iot-khl0ljiipentakuw-items logs rats-1119aa2aa1ae41a9943f9f19780edb8e-5d549c4fc6-l54ch | sed 's/:::LF:::/~/g' | tr '~' '\n'
```

```
[2020-09-18 14:20:40.559] [WARN] [com.esri.realtime.core.execution.ContextHolder$] [2020-09-18T14:20:40.559Z] [com.esri.realtime.core.execution.ContextHolder$] [unknown] [null] [null] [khl0ljiipentakuw] [1119aa2aa1ae41a9943f9f19780edb8e] [raspmulti1] [admin] [{0} is not set in current context. WARNING returning null] ["metricsReporter"] metricsReporter is not set in current context. WARNING returning null

[2020-09-18 14:20:42.124] [WARN] [com.esri.realtime.io.output.arcgis.CreateFeatureLayerForKafkaStreams] [2020-09-18T14:20:42.124Z] [com.esri.realtime.io.output.arcgis.CreateFeatureLayerForKafkaStreams] [unknown] [null] [null] [khl0ljiipentakuw] [1119aa2aa1ae41a9943f9f19780edb8e] [raspmulti1] [user] [VALIDATION_OUTPUT_FEAT_LYR_NEW__INVALID_DATASET_NO_REPLACE] [] An issue was identified with this output dataset. Please save your analytic changes and refresh your browser tab. If this message is still encountered, please contact Esri Support for assistance or delete and recreate this output.

[2020-09-18 14:20:42.432] [WARN] [com.esri.realtime.io.output.arcgis.CreateFeatureLayerForKafkaStreams] [2020-09-18T14:20:42.432Z] [com.esri.realtime.io.output.arcgis.CreateFeatureLayerForKafkaStreams] [unknown] [null] [null] [khl0ljiipentakuw] [1119aa2aa1ae41a9943f9f19780edb8e] [raspmulti1] [user] [VALIDATION_OUTPUT_FEAT_LYR_NEW__INVALID_DATASET_NO_REPLACE] [] An issue was identified with this output dataset. Please save your analytic changes and refresh your browser tab. If this message is still encountered, please contact Esri Support for assistance or delete and recreate this output.

[2020-09-18 14:20:42.807] [ERROR] [com.esri.realtime.processing.RealTimeAnalyticTaskExecutor$] [2020-09-18T14:20:42.807Z] [com.esri.realtime.processing.RealTimeAnalyticTaskExecutor$] [output] [feat-lyr-new] [BAT_SOAK_RAT_Output_KeepLatestFeatures-2639] [khl0ljiipentakuw] [1119aa2aa1ae41a9943f9f19780edb8e] [raspmulti1] [user] [RATS__EXECUTOR__CATCH_ALL_FAILURE] ["1119aa2aa1ae41a9943f9f19780edb8e"] Real time analytic id: 1119aa2aa1ae41a9943f9f19780edb8e execution failed.

[2020-09-18 14:20:42.807] [ERROR] [com.esri.realtime.processing.RealTimeAnalyticTaskExecutor$] [2020-09-18T14:20:42.807Z] [com.esri.realtime.processing.RealTimeAnalyticTaskExecutor$] [output] [feat-lyr-new] [BAT_SOAK_RAT_Output_KeepLatestFeatures-2639] [khl0ljiipentakuw] [1119aa2aa1ae41a9943f9f19780edb8e] [raspmulti1] [admin] [RATS__EXECUTOR__CATCH_ALL_FAILURE] ["1119aa2aa1ae41a9943f9f19780edb8e"] Real time analytic id: 1119aa2aa1ae41a9943f9f19780edb8e execution failed.
 com.esri.realtime.processing.ProcessingStageExecutionException: java.lang.NullPointerException
	at com.esri.realtime.processing.RealTimeAnalyticTaskExecutor$.delayedEndpoint$com$esri$realtime$processing$RealTimeAnalyticTaskExecutor$1(RealTimeAnalyticTaskExecutor.scala:139)
	at com.esri.realtime.processing.RealTimeAnalyticTaskExecutor$delayedInit$body.apply(RealTimeAnalyticTaskExecutor.scala:27)
	at scala.Function0$class.apply$mcV$sp(Function0.scala:34)
	at scala.runtime.AbstractFunction0.apply$mcV$sp(AbstractFunction0.scala:12)
	at scala.App$$anonfun$main$1.apply(App.scala:76)
	at scala.App$$anonfun$main$1.apply(App.scala:76)
	at scala.collection.immutable.List.foreach(List.scala:392)
	at scala.collection.generic.TraversableForwarder$class.foreach(TraversableForwarder.scala:35)
	at scala.App$class.main(App.scala:76)
	at com.esri.realtime.processing.RealTimeAnalyticTaskExecutor$.main(RealTimeAnalyticTaskExecutor.scala:27)
	at com.esri.realtime.processing.RealTimeAnalyticTaskExecutor.main(RealTimeAnalyticTaskExecutor.scala)
Caused by: java.lang.NullPointerException
	at com.esri.realtime.io.output.arcgis.BDSUtil$.createServiceDefinitionJson(BDSUtil.scala:194)
	at com.esri.realtime.io.output.arcgis.BDSUtil$.publishServices(BDSUtil.scala:156)
	at com.esri.realtime.io.output.arcgis.CreateFeatureLayerForKafkaStreams.beforeExecute(CreateFeatureLayerForKafkaStreams.scala:95)
	at com.esri.realtime.processing.PipelineExecutorForKafkaStreamsImpl$$anonfun$beforeExecute$1.apply(PipelineExecutorForKafkaStreams.scala:85)
	at com.esri.realtime.processing.PipelineExecutorForKafkaStreamsImpl$$anonfun$beforeExecute$1.apply(PipelineExecutorForKafkaStreams.scala:82)
	at scala.collection.mutable.HashMap$$anon$2$$anonfun$foreach$3.apply(HashMap.scala:139)
	at scala.collection.mutable.HashMap$$anon$2$$anonfun$foreach$3.apply(HashMap.scala:139)
	at scala.collection.mutable.HashTable$class.foreachEntry(HashTable.scala:236)
	at scala.collection.mutable.HashMap.foreachEntry(HashMap.scala:40)
	at scala.collection.mutable.HashMap$$anon$2.foreach(HashMap.scala:139)
	at com.esri.realtime.processing.PipelineExecutorForKafkaStreamsImpl.beforeExecute(PipelineExecutorForKafkaStreams.scala:82)
	at com.esri.realtime.processing.PipelineTask$class.start(PipelineTask.scala:38)
	at com.esri.realtime.processing.RealTimeAnalyticTaskForKafkaStreams.start(RealTimeAnalyticTask.scala:82)
	at com.esri.realtime.processing.RealTimeAnalyticTaskExecutor$.delayedEndpoint$com$esri$realtime$processing$RealTimeAnalyticTaskExecutor$1(RealTimeAnalyticTaskExecutor.scala:121)
	... 10 more
```
