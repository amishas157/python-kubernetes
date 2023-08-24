from flask import Flask
from flask_restful import Resource, Api
from pyspark.sql import SparkSession

app = Flask(__name__)
api = Api(app)

class HelloWorld(Resource):
    def get(self):
        return "Hello Python!"

api.add_resource(HelloWorld, '/')

if __name__ == '__main__':
    spark = SparkSession.builder.appName("SparkOnKubernetesDemo").getOrCreate()
    df = spark.read.format("csv").load("./data/sample.csv")
    df.show()
    app.run(host='0.0.0.0')
