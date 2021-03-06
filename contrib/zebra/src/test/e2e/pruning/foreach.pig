/**
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

register /grid/0/dev/hadoopqa/jars/zebra.jar;
a1 = load '1.txt' as (a:int, b:float,c:long,d:double,e:chararray,f:bytearray,r1(f1:chararray,f2:chararray),m1:map[]);

a2 = load '2.txt' as (a:int, b:float,c:long,d:double,e:chararray,f:bytearray,r1(f1:chararray,f2:chararray),m1:map[]);

n2 = foreach a1 generate a;

--this store will fail since there is no b and c
--store n2 into 'foreach1' using org.apache.hadoop.zebra.pig.TableStorer('[a];[b];[c]');

--this store will pass
store n2 into 'foreach1' using org.apache.hadoop.zebra.pig.TableStorer('[a]');

--this load will pass, the second column 'b' will return empty string
a3 = load 'foreach1' using org.apache.hadoop.zebra.pig.TableLoader('a,b');
dump a3;
--store a2 into 'foreach2' using org.apache.hadoop.zebra.pig.TableStorer('[a,b,c];[d,e,f,r1,m1]');

