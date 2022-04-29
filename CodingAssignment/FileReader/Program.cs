using FileReader.Service;

namespace FileReader
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello, welcome to my File Import System(Json or Yaml)!");
            string path = AskForJsonFileName();
            var extention = Path.GetExtension(path);
            if(extention == ".json")
            {
                ReadService.ReadJsonFile(path);
            }
            else
            {
                ReadService.ReadYamlFile(path);
            }
        }

        public static string AskForJsonFileName()
        {
        BEGIN:
            Console.Write("\nWhat is the path of your JSON/YAML file? ");
            var _path = Console.ReadLine();
            if (File.Exists(_path))
            {
                return _path;
            }
            else
            {
                Console.Write("\nError: File doesn't exist!");
                goto BEGIN;
            }
        }
    }
}