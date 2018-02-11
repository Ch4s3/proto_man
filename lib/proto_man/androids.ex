defmodule ProtoMan.Androids do
  use Protobuf, """
    message Android {
      message Health {
        required uint32 value = 1;
      }
      enum SpecialWeapon {
        MegaBuster = 0;
        AtomicFire = 1;
        ProtoShield = 2;
        AtomicFire = 3;
        DrillBomb = 4;
      }
      enum Version {
        V1 = 1;
        V2 = 2;
      }
      required string name = 1;
      required SpecialWeapon special_weapon = 2;
      required Version version = 3;
      optional Health hp = 4;
    }
  """

  def safe_decode(bytes) do
    try do
      {:ok, ProtoMan.Androids.Android.decode(bytes)}
    rescue
      ErlangError ->
        {:error, "Error encoding data"}
    end
  end
end
