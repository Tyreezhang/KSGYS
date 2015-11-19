using PetaPoco;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Binary;
using System.Text;
using System.Threading.Tasks;

namespace PetaPoco
{
    public partial class Database
    {
        public IDbCommand CreateProcCommand(IDbConnection connection, string sql, params object[] args)
        {
            var cmd = CreateCommand(connection, sql, args);
            cmd.CommandType = CommandType.StoredProcedure;
            return cmd;
        }

        public int ExecuteProc(string sql, params object[] args)
        {
            try
            {
                OpenSharedConnection();
                try
                {
                    using (var cmd = CreateProcCommand(_sharedConnection, sql, args))
                    {
                        var retv = cmd.ExecuteNonQuery();
                        OnExecutedCommand(cmd);
                        return retv;
                    }
                }
                finally
                {
                    CloseSharedConnection();
                }
            }
            catch (Exception x)
            {
                if (OnException(x))
                    throw;
                return -1;
            }
        }

        public IEnumerable<T> QueryNoAutoSelect<T>(string sql, params object[] args)
        {
            OpenSharedConnection();
            try
            {
                using (var cmd = CreateCommand(_sharedConnection, sql, args))
                {
                    IDataReader r;
                    var pd = PetaPoco.Internal.PocoData.ForType(typeof(T));
                    try
                    {
                        r = cmd.ExecuteReader();
                        OnExecutedCommand(cmd);
                    }
                    catch (Exception x)
                    {
                        if (OnException(x))
                            throw;
                        yield break;
                    }
                    var factory = pd.GetFactory(cmd.CommandText, _sharedConnection.ConnectionString, 0, r.FieldCount, r) as Func<IDataReader, T>;
                    using (r)
                    {
                        while (true)
                        {
                            T poco;
                            try
                            {
                                if (!r.Read())
                                    yield break;
                                poco = factory(r);
                            }
                            catch (Exception x)
                            {
                                if (OnException(x))
                                    throw;
                                yield break;
                            }

                            yield return poco;
                        }
                    }
                }
            }
            finally
            {
                CloseSharedConnection();
            }
        }

        public List<T> FetchNoAutoSelect<T>(string sql, params object[] args)
        {
            return QueryNoAutoSelect<T>(sql, args).ToList();
        }

        /// <summary>
        /// 序列化对象
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="objs"></param>
        /// <returns></returns>
        internal static byte[] Serialize<T>(T objs)
        {
            IFormatter ift = new BinaryFormatter();
            byte[] byts = null;
            using (MemoryStream ms = new MemoryStream())
            {
                ift.Serialize(ms, objs);
                byts = ms.GetBuffer();
            }
            return byts;
        }

        /// <summary>
        /// 序列化对象为Json串
        /// </summary>
        /// <param name="obj">要被序列化的对象</param>
        /// <returns></returns>
        internal static string SerializeJson(object obj)
        {
            return Newtonsoft.Json.JsonConvert.SerializeObject(obj);
        }

        /// <summary>
        /// 反序列化对象
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <param name="jsonstr">Json串</param>
        /// <returns></returns>
        internal static T DeSerialize<T>(string jsonstr)
        {
            return Newtonsoft.Json.JsonConvert.DeserializeObject<T>(jsonstr);
        }

        /// <summary>
        /// 反序列化对象
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="byts"></param>
        /// <returns></returns>
        internal static T DeSerialize<T>(byte[] byts)
        {
            IFormatter ift = new BinaryFormatter();
            using (MemoryStream ms = new MemoryStream(byts))
            {
                return (T)ift.Deserialize(ms);
            }
        }

        /// <summary>
        /// 深表复制对象
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="objsrc"></param>
        /// <returns></returns>
        public static T DeepCopy<T>(T objsrc)
        {
            if (null == objsrc) return objsrc;
            return DeSerialize<T>(Serialize<T>(objsrc));
        }
    }

}

