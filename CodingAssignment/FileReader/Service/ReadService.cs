using FileReader.Model;
using Newtonsoft.Json;
using YamlDotNet.Serialization.NamingConventions;

namespace FileReader.Service
{
    public class ReadService
    {
        public static void ReadJsonFile(string jsonFileIn)
        {
			try
			{
				string jsonFromFile;
				using (var reader = new StreamReader(jsonFileIn))
				{
					jsonFromFile = reader.ReadToEnd();
				}

				var productsList = JsonConvert.DeserializeObject<ProductsList>(jsonFromFile);

				for(int i = 0; i < productsList.products.Count(); i++)
				{
					for (int j = 0; j < productsList.products[i].categories.Length; j++)
                    {
						Console.WriteLine($"importing: Name: {productsList.products[i].title};  Categories: {productsList.products[i].categories[j]}; Twitter: {productsList.products[i].twitter}");
					}
				}
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
			}
			Console.WriteLine("Press any key to exit.");
			Console.ReadKey();
		}

		public static void ReadYamlFile(string yamlFileIn)
        {
            try
            {
				var deserializer = new YamlDotNet.Serialization.DeserializerBuilder().WithNamingConvention(CamelCaseNamingConvention.Instance).Build();
				var productsList = deserializer.Deserialize<ProductsList>(File.ReadAllText(yamlFileIn));

				for (int i = 0; i < productsList.products.Count(); i++)
				{
					for (int j = 0; j < productsList.products[i].categories.Length; j++)
					{
						Console.WriteLine($"importing: Name: {productsList.products[i].title};  Categories: {productsList.products[i].categories[j]}; Twitter: {productsList.products[i].twitter}");
					}
				}

			}
			catch (Exception ex)
            {
				Console.WriteLine(ex.Message);
			}
			Console.WriteLine("Press any key to exit.");
			Console.ReadKey();
		}
	}
}
