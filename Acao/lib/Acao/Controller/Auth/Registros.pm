package Acao::Controller::Auth::Registros;
# Copyright 2010 - Prefeitura Municipal de Fortaleza
#
# Este arquivo é parte do programa Ação - Sistema de Acompanhamento de
# Projetos Sociais
#
# O Ação é um software livre; você pode redistribui-lo e/ou modifica-lo
# dentro dos termos da Licença Pública Geral GNU como publicada pela
# Fundação do Software Livre (FSF); na versão 2 da Licença.
#
# Este programa é distribuido na esperança que possa ser util, mas SEM
# NENHUMA GARANTIA; sem uma garantia implicita de ADEQUAÇÂO a qualquer
# MERCADO ou APLICAÇÃO EM PARTICULAR. Veja a Licença Pública Geral GNU
# para maiores detalhes.
#
# Você deve ter recebido uma cópia da Licença Pública Geral GNU, sob o
# título "LICENCA.txt", junto com este programa, se não, escreva para a
# Fundação do Software Livre(FSF) Inc., 51 Franklin St, Fifth Floor,

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Acao::Controller::Auth::Registros - Raiz da área de registros.

=head1 ACTIONS

=over

=item base

Ação raiz da área de registros.

=cut

sub base : Chained('/auth/base') : PathPart('registros') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

=item principal

Se o usuário tem acesso apenas à ação de digitador ou revisor,
redireciona para a área específica. De outra forma delega à view uma
lista das sub-áreas da área de registros.

=cut

sub principal : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;
    my @roles = $c->user->roles;
  #  warn @roles;
    if ( ( grep { /^revisor$/ } @roles )
        && !( grep { /^digitador$/ } @roles ) )
    {
        $c->res->redirect( $c->uri_for('/auth/registros/revisor') );
    }
    elsif ( ( grep { /^digitador$/ } @roles )
        && !( grep { /^revisor$/ } @roles ) )
    {
        $c->res->redirect( $c->uri_for('/auth/registros/digitador') );
    }
}

=back

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

1;
