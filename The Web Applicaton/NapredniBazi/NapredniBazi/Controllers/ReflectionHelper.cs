using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Web;

namespace NapredniBazi.Controllers
{
    public class ReflectionHelper
    {
        public static List<T> MapDataToBusinessEntityCollection<T>
(IDataReader dr)
   where T : new()
        {
            Type businessEntityType = typeof(T);
            List<T> entitys = new List<T>();
            Hashtable hashtable = new Hashtable();
            PropertyInfo[] properties = businessEntityType.GetProperties();
            foreach (PropertyInfo info in properties)
            {
                hashtable[info.Name.ToUpper()] = info;
            }
            while (dr.Read())
            {
                T newObject = new T();
                for (int index = 0; index < dr.FieldCount; index++)
                {
                    string propertyName = dr.GetName(index).ToUpper();
                    PropertyInfo info = (PropertyInfo)
                                        hashtable[propertyName];
                    if ((info != null) && info.CanWrite)
                    {
                        info.SetValue(newObject, dr.GetValue(index), null);
                    }
                }
                entitys.Add(newObject);
            }
            dr.Close();
            return entitys;
        }
    }
}