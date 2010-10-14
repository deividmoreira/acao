package Acao::Plugins::SDH::DimSchema::Result::DTipoIluminacao;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Acao::Plugins::SDH::DimSchema::Result::DTipoIluminacao

=cut

__PACKAGE__->table("d_tipo_iluminacao");

=head1 ACCESSORS

=head2 id_tipo_iluminacao

  data_type: 'integer'
  is_nullable: 0

=head2 tipo_iluminacao

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "id_tipo_iluminacao",
  { data_type => "integer", is_nullable => 0 },
  "tipo_iluminacao",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
);
__PACKAGE__->set_primary_key("id_tipo_iluminacao");

=head1 RELATIONS

=head2 f_atendimentoes

Type: has_many

Related object: L<Acao::Plugins::SDH::DimSchema::Result::FAtendimento>

=cut

__PACKAGE__->has_many(
  "f_atendimentoes",
  "Acao::Plugins::SDH::DimSchema::Result::FAtendimento",
  { "foreign.id_tipo_iluminacao" => "self.id_tipo_iluminacao" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-14 15:32:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:NGtkDkFih4WyrE4K12ilbQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
