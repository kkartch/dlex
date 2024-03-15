
defmodule Dlex.Api.Request.RespFormat do
  @moduledoc false

  use Protobuf, enum: true, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :JSON, 0
  field :RDF, 1
end

defmodule Dlex.Api.Operation.DropOp do
  @moduledoc false

  use Protobuf, enum: true, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :NONE, 0
  field :ALL, 1
  field :DATA, 2
  field :ATTR, 3
  field :TYPE, 4
end

defmodule Dlex.Api.Facet.ValType do
  @moduledoc false

  use Protobuf, enum: true, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :STRING, 0
  field :INT, 1
  field :FLOAT, 2
  field :BOOL, 3
  field :DATETIME, 4
end

defmodule Dlex.Api.Request.VarsEntry do
  @moduledoc false

  use Protobuf, map: true, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :key, 1, type: :string
  field :value, 2, type: :string
end

defmodule Dlex.Api.Request do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :start_ts, 1, type: :uint64, json_name: "startTs"
  field :query, 4, type: :string
  field :vars, 5, repeated: true, type: Dlex.Api.Request.VarsEntry, map: true
  field :read_only, 6, type: :bool, json_name: "readOnly"
  field :best_effort, 7, type: :bool, json_name: "bestEffort"
  field :mutations, 12, repeated: true, type: Dlex.Api.Mutation
  field :commit_now, 13, type: :bool, json_name: "commitNow"
  field :resp_format, 14, type: Dlex.Api.Request.RespFormat, json_name: "respFormat", enum: true
  field :hash, 15, type: :string
end

defmodule Dlex.Api.Uids do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :uids, 1, repeated: true, type: :string
end

defmodule Dlex.Api.ListOfString do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :value, 1, repeated: true, type: :string
end

defmodule Dlex.Api.Response.UidsEntry do
  @moduledoc false

  use Protobuf, map: true, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :key, 1, type: :string
  field :value, 2, type: :string
end

defmodule Dlex.Api.Response.HdrsEntry do
  @moduledoc false

  use Protobuf, map: true, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :key, 1, type: :string
  field :value, 2, type: Dlex.Api.ListOfString
end

defmodule Dlex.Api.Response do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :json, 1, type: :bytes
  field :txn, 2, type: Dlex.Api.TxnContext
  field :latency, 3, type: Dlex.Api.Latency
  field :metrics, 4, type: Dlex.Api.Metrics
  field :uids, 12, repeated: true, type: Dlex.Api.Response.UidsEntry, map: true
  field :rdf, 13, type: :bytes
  field :hdrs, 14, repeated: true, type: Dlex.Api.Response.HdrsEntry, map: true
end

defmodule Dlex.Api.Mutation do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :set_json, 1, type: :bytes, json_name: "setJson"
  field :delete_json, 2, type: :bytes, json_name: "deleteJson"
  field :set_nquads, 3, type: :bytes, json_name: "setNquads"
  field :del_nquads, 4, type: :bytes, json_name: "delNquads"
  field :set, 5, repeated: true, type: Dlex.Api.NQuad
  field :del, 6, repeated: true, type: Dlex.Api.NQuad
  field :cond, 9, type: :string
  field :commit_now, 14, type: :bool, json_name: "commitNow"
end

defmodule Dlex.Api.Operation do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :schema, 1, type: :string
  field :drop_attr, 2, type: :string, json_name: "dropAttr"
  field :drop_all, 3, type: :bool, json_name: "dropAll"
  field :drop_op, 4, type: Dlex.Api.Operation.DropOp, json_name: "dropOp", enum: true
  field :drop_value, 5, type: :string, json_name: "dropValue"
  field :run_in_background, 6, type: :bool, json_name: "runInBackground"
end

defmodule Dlex.Api.Payload do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :Data, 1, type: :bytes
end

defmodule Dlex.Api.TxnContext do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :start_ts, 1, type: :uint64, json_name: "startTs"
  field :commit_ts, 2, type: :uint64, json_name: "commitTs"
  field :aborted, 3, type: :bool
  field :keys, 4, repeated: true, type: :string
  field :preds, 5, repeated: true, type: :string
  field :hash, 6, type: :string
end

defmodule Dlex.Api.Check do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"
end

defmodule Dlex.Api.Version do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :tag, 1, type: :string
end

defmodule Dlex.Api.Latency do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :parsing_ns, 1, type: :uint64, json_name: "parsingNs"
  field :processing_ns, 2, type: :uint64, json_name: "processingNs"
  field :encoding_ns, 3, type: :uint64, json_name: "encodingNs"
  field :assign_timestamp_ns, 4, type: :uint64, json_name: "assignTimestampNs"
  field :total_ns, 5, type: :uint64, json_name: "totalNs"
end

defmodule Dlex.Api.Metrics.NumUidsEntry do
  @moduledoc false

  use Protobuf, map: true, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :key, 1, type: :string
  field :value, 2, type: :uint64
end

defmodule Dlex.Api.Metrics do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :num_uids, 1,
    repeated: true,
    type: Dlex.Api.Metrics.NumUidsEntry,
    json_name: "numUids",
    map: true
end

defmodule Dlex.Api.NQuad do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :subject, 1, type: :string
  field :predicate, 2, type: :string
  field :object_id, 3, type: :string, json_name: "objectId"
  field :object_value, 4, type: Dlex.Api.Value, json_name: "objectValue"
  field :lang, 6, type: :string
  field :facets, 7, repeated: true, type: Dlex.Api.Facet
  field :namespace, 8, type: :uint64
end

defmodule Dlex.Api.Value do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  oneof :val, 0

  field :default_val, 1, type: :string, json_name: "defaultVal", oneof: 0
  field :bytes_val, 2, type: :bytes, json_name: "bytesVal", oneof: 0
  field :int_val, 3, type: :int64, json_name: "intVal", oneof: 0
  field :bool_val, 4, type: :bool, json_name: "boolVal", oneof: 0
  field :str_val, 5, type: :string, json_name: "strVal", oneof: 0
  field :double_val, 6, type: :double, json_name: "doubleVal", oneof: 0
  field :geo_val, 7, type: :bytes, json_name: "geoVal", oneof: 0
  field :date_val, 8, type: :bytes, json_name: "dateVal", oneof: 0
  field :datetime_val, 9, type: :bytes, json_name: "datetimeVal", oneof: 0
  field :password_val, 10, type: :string, json_name: "passwordVal", oneof: 0
  field :uid_val, 11, type: :uint64, json_name: "uidVal", oneof: 0
end

defmodule Dlex.Api.Facet do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :key, 1, type: :string
  field :value, 2, type: :bytes
  field :val_type, 3, type: Dlex.Api.Facet.ValType, json_name: "valType", enum: true
  field :tokens, 4, repeated: true, type: :string
  field :alias, 5, type: :string
end

defmodule Dlex.Api.LoginRequest do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :userid, 1, type: :string
  field :password, 2, type: :string
  field :refresh_token, 3, type: :string, json_name: "refreshToken"
  field :namespace, 4, type: :uint64
end

defmodule Dlex.Api.Jwt do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :access_jwt, 1, type: :string, json_name: "accessJwt"
  field :refresh_jwt, 2, type: :string, json_name: "refreshJwt"
end

defmodule Dlex.Api.Dgraph.Service do
  @moduledoc false

  use GRPC.Service, name: "api.Dgraph", protoc_gen_elixir_version: "0.12.0"

  rpc :Login, Dlex.Api.LoginRequest, Dlex.Api.Response

  rpc :Query, Dlex.Api.Request, Dlex.Api.Response

  rpc :Alter, Dlex.Api.Operation, Dlex.Api.Payload

  rpc :CommitOrAbort, Dlex.Api.TxnContext, Dlex.Api.TxnContext

  rpc :CheckVersion, Dlex.Api.Check, Dlex.Api.Version
end

defmodule Dlex.Api.Dgraph.Stub do
  @moduledoc false

  use GRPC.Stub, service: Dlex.Api.Dgraph.Service
end
