/* 
 *  TOPPERS ATK2
 *      Toyohashi Open Platform for Embedded Real-Time Systems
 *      Automotive Kernel Version 2
 *  
 *  Copyright (C) 2007-2012 by TAKAGI Nobuhisa
 *  Copyright (C) 2010 by Meika Sugimoto
 *  Copyright (C) 2011-2012 by Center for Embedded Computing Systems
 *              Graduate School of Information Science, Nagoya Univ., JAPAN
 *  Copyright (C) 2011-2012 by FUJISOFT INCORPORATED, JAPAN
 *  Copyright (C) 2011-2012 by FUJITSU VLSI LIMITED, JAPAN
 *  Copyright (C) 2011-2012 by NEC Communication Systems, Ltd., JAPAN
 *  Copyright (C) 2011-2012 by Panasonic Advanced Technology Development Co., Ltd., JAPAN
 *  Copyright (C) 2011-2012 by Renesas Electronics Corporation, JAPAN
 *  Copyright (C) 2011-2012 by Sunny Giken Inc., JAPAN
 *  Copyright (C) 2011-2012 by TOSHIBA CORPOTATION, JAPAN
 *  Copyright (C) 2011-2012 by Witz Corporation, JAPAN
 *  
 *  �嵭����Ԥϡ��ʲ���(1)��(4)�ξ������������˸¤ꡤ�ܥ��եȥ���
 *  �����ܥ��եȥ���������Ѥ�����Τ�ޤࡥ�ʲ�Ʊ���ˤ���ѡ�ʣ������
 *  �ѡ������ۡʰʲ������ѤȸƤ֡ˤ��뤳�Ȥ�̵���ǵ������롥
 *  (1) �ܥ��եȥ������򥽡��������ɤη������Ѥ�����ˤϡ��嵭������
 *      ��ɽ�����������Ѿ�浪��Ӳ�����̵�ݾڵ��꤬�����Τޤޤη��ǥ���
 *      ����������˴ޤޤ�Ƥ��뤳�ȡ�
 *  (2) �ܥ��եȥ������򡤥饤�֥������ʤɡ�¾�Υ��եȥ�������ȯ�˻�
 *      �ѤǤ�����Ǻ����ۤ�����ˤϡ������ۤ�ȼ���ɥ�����ȡ�����
 *      �ԥޥ˥奢��ʤɡˤˡ��嵭�����ɽ�����������Ѿ�浪��Ӳ���
 *      ��̵�ݾڵ����Ǻܤ��뤳�ȡ�
 *  (3) �ܥ��եȥ������򡤵�����Ȥ߹���ʤɡ�¾�Υ��եȥ�������ȯ�˻�
 *      �ѤǤ��ʤ����Ǻ����ۤ�����ˤϡ����Τ����줫�ξ�����������
 *      �ȡ�
 *    (a) �����ۤ�ȼ���ɥ�����ȡ����Ѽԥޥ˥奢��ʤɡˤˡ��嵭����
 *        �ɽ�����������Ѿ�浪��Ӳ�����̵�ݾڵ����Ǻܤ��뤳�ȡ�
 *    (b) �����ۤη��֤��̤�������ˡ�ˤ�äơ�TOPPERS�ץ��������Ȥ�
 *        ��𤹤뤳�ȡ�
 *  (4) �ܥ��եȥ����������Ѥˤ��ľ��Ū�ޤ��ϴ���Ū�������뤤���ʤ�»
 *      ������⡤�嵭����Ԥ����TOPPERS�ץ��������Ȥ����դ��뤳�ȡ�
 *      �ޤ����ܥ��եȥ������Υ桼���ޤ��ϥ���ɥ桼������Τ����ʤ���
 *      ͳ�˴�Ť����ᤫ��⡤�嵭����Ԥ����TOPPERS�ץ��������Ȥ�
 *      ���դ��뤳�ȡ�
 *  
 *  �ܥ��եȥ������ϡ�̵�ݾڤ��󶡤���Ƥ����ΤǤ��롥�嵭����Ԥ�
 *  ���TOPPERS�ץ��������Ȥϡ��ܥ��եȥ������˴ؤ��ơ�����λ�����Ū
 *  ���Ф���Ŭ������ޤ�ơ������ʤ��ݾڤ�Ԥ�ʤ����ޤ����ܥ��եȥ���
 *  �������Ѥˤ��ľ��Ū�ޤ��ϴ���Ū�������������ʤ�»���˴ؤ��Ƥ⡤��
 *  ����Ǥ�����ʤ���
 * 
 *  $Id: factory.cpp 133 2012-12-18 04:30:30Z ertl-hiro $
 */
 
#include <cstring>
#include <cstdlib>
#include <fstream>
#include <boost/algorithm/string.hpp>
#include <boost/lexical_cast.hpp>
#include "toppers/misc.hpp"
#include "toppers/global.hpp"
#include "toppers/csv.hpp"
#include "toppers/nm_symbol.hpp"
#include "toppers/s_record.hpp"
#include "toppers/diagnostics.hpp"
#include "toppers/macro_processor.hpp"
#include "toppers/io.hpp"
#include "toppers/cpp.hpp"
#include "toppers/xml/factory.hpp"
#include "toppers/xml/cfg1_out.hpp"

namespace toppers
{
  namespace xml
  {
    namespace
    {
       container::object* find_object( std::string const& name , cfg1_out::xml_obj_map const& xml_map , cfg1_out const& cfg1out )
      {
        std::map< std::string, std::vector< container::object* > >::const_iterator p;
        std::vector< container::object* >::const_iterator q, q2;
        int fObject = 0;

        // ̾�������פ��륪�֥������Ȥ򸡺�
        string::size_type index = name.find_last_of("/");
        string container_name = name.substr(0,index);
        string parameter_name = name.substr(index+1);

        for(p = xml_map.begin() ; p != xml_map.end() ; p++)
        {
          for( q = (*p).second.begin() ; q != (*p).second.end() ; q++ )
          {
            if( parameter_name == (*q)->getObjName() )
            {
              string defname = cfg1out.search_info_pathname( (*q)->getDefName() );
              // �ե�ѥ��Υ���ƥ�̾������å�
              if ( defname.find( name ) != string::npos )
              {
                return (*q);
              }
              // �ե�ѥ��Ȱ��פ��ʤ��Ƥ⥪�֥�������̾�����פ��Ƥ���Τ���¸
              q2 = q;
              fObject++;
            }
          }
        }
        if ( fObject > 0 )
          return (*q2);
        else
          return NULL;
      }

      // �����ͥ륪�֥��������������������ŪAPI�γƥѥ�᡼����ޥ����ץ����å����ѿ��Ȥ������ꤹ�롣
      void set_object_vars( cfg1_out const& cfg1out, cfg1_out::xml_obj_map const& xml_map, macro_processor& mproc )
      {
        typedef macro_processor::element element;
        typedef macro_processor::var_t var_t;
        std::map< std::string, var_t > order_list_map;
        std::map< std::string, long > id_map;

        using namespace toppers::xml::container;
        std::map< std::string, std::vector<object*> >::const_iterator p;
        std::vector<object*>::const_iterator q;
        std::vector<parameter*>::const_iterator r;

        std::size_t sizeof_signed_t;
        std::size_t sizeof_pointer;
        nm_symbol::entry nm_entry = cfg1out.get_syms()->find( "TOPPERS_cfg_sizeof_signed_t" );
        sizeof_signed_t = static_cast< std::size_t >( cfg1out.get_srec()->get_value( nm_entry.address, 4, cfg1out.is_little_endian() ) );

        nm_entry = cfg1out.get_syms()->find( "TOPPERS_cfg_sizeof_pointer" );
        sizeof_pointer = static_cast< std::size_t >( cfg1out.get_srec()->get_value( nm_entry.address, 4, cfg1out.is_little_endian() ) );

        for ( p = xml_map.begin() ; p != xml_map.end() ; p++)
        {
          element e;
          var_t t;
          string name;
          long obj_id;
          long param_id;

          // �ѥ�᡼����������
          for(q = (*p).second.begin() ; q != (*p).second.end() ; q++)
          {
            std::map< std::string, var_t > obj_parameter;
            std::map< std::string, var_t >::iterator s;
            obj_id = (*q)->getId();
            name = (*p).first;
            std::map<std::string , long> id_count;
            std::map<std::string , long>::iterator id_iter;

            // �ͤμ��Ф�
            e.i = obj_id;
            e.s = (*q)->getObjName();
            // �и���ꥹ���Ѥξ������
            order_list_map[ name ].push_back(e);
            // ���֥������ȼ��Ȥ�������
            mproc.set_var( toppers::toupper(name), obj_id, var_t( 1, e ) );
            // �ƥ���ƥʤ�������Ϥ��ξ������Ͽ
            if( (*q)->getParent() != NULL )
            {
              e.s = (*q)->getParent()->getObjName();
              e.i = (*q)->getParent()->getId();
              mproc.set_var( toppers::toupper(name)+".PARENT", obj_id, var_t( 1, e ) );
            }

            // ���֥������ȥ��Ф�������
            for(r = (*q)->getParams()->begin() ; r != (*q)->getParams()->end() ; r++)
            {
              name = (*p).first+ string(".") + (*r)->getDefName();
              e.s = (*r)->getValue();

              if(e.s == string(""))
              {
                continue;
              }

              // ���Ф�ID�򸡺�
              id_iter = id_count.find(name);
              if(id_iter == id_count.end())
              {
                id_count[name] = 0;
                param_id = 0;
              }
              else
              {
                param_id = (*id_iter).second + 1;
                id_count[name] = (*id_iter).second + 1;
              }

              if((*r)->getType() == TYPE_INT || (*r)->getType() == TYPE_FLOAT)
              {
                string value_str( (*r)->getValue() );
                try
                {
                  e.i = boost::lexical_cast< std::tr1::int64_t >( value_str );
                }
                catch( std::exception& exception )
                {
                  string contanerDefName( (*r)->getParent()->getDefName() );
                  string paramDefName( (*r)->getDefName() );
                  string grandObjName;

                  boost::replace_all(contanerDefName, ".", "_");
                  boost::replace_all(paramDefName, ".", "_");
                  if( (*r)->getParent()->getParent() != NULL )
                  {
                    grandObjName = (*r)->getParent()->getParent()->getObjName();
                  }

                  nm_entry = cfg1out.get_syms()->find( "TOPPERS_cfg_valueof_" + contanerDefName + "_" + paramDefName + "_" + (*r)->getParent()->getObjName() + "_" + grandObjName );
                  if ( nm_entry.type >= 0 )
                  {
                    e.i = cfg1out.get_srec()->get_value( nm_entry.address, sizeof_pointer, cfg1out.is_little_endian() );
                  }
                  else
                  {
                    e.i = 0;
                  }
                }
              }
              else if( (*r)->getType() == TYPE_REF)
              {
                object *obj;
                string refefence_obj_type;

                // ���֥�������ID��õ��
                e.i = 0;
                obj = find_object( (*r)->getValue() , xml_map, cfg1out );
                if(obj != NULL)
                {
                  e.i = obj->getId();
                  e.s = e.s.substr(e.s.find_last_of("/")+1);
                }
                else
                {
                  toppers::fatal( _( "(%1%:%2%) : not match Refernce ID filds in `%3%\'" ), (*r)->getFileName(), (*r)->getLine(), (*r)->getValue() );
                }
              }
              else if( (*r)->getType() == TYPE_BOOLEAN )
              {
                string value_str( (*r)->getValue() );
                if(value_str == "1" || value_str == "TRUE" || value_str == "true")
                {
                  e.i = 1;
                }
                else
                {
                  e.i = 0;
                }
              }
              else
              {
                e.i = 0;
              }

              if((*r)->getType() != TYPE_UNKNOWN)
              {
                obj_parameter[name].push_back(e);

                // �ѥ�᡼���������и��������ֹ�
                {
                  element e;
                  e.s = (*q)->getFileName();
                  e.i = (*r)->getLine() + 1;

                  mproc.set_var( name + ".TEXT_LINE", obj_id, var_t( 1, e ) );
                }
              }

            }

            for(s = obj_parameter.begin() ; s != obj_parameter.end() ; s++)
            {
              mproc.set_var((*s).first , obj_id , (*s).second );
            }

            // ����ƥʥ������и��������ֹ�
            {
              element e;
              e.s = (*q)->getFileName();
              e.i = (*q)->getLine() + 1;

              mproc.set_var( (*p).first + ".TEXT_LINE", obj_id, var_t( 1, e ) );

              // ����ƥʤη��拾��ƥʿ�
              e.s = (*q)->getSiblings();
              e.i = (*q)->getSiblings();
              mproc.set_var( (*p).first + ".SIBLINGS", obj_id, var_t( 1, e ) );
            }

          }

        }
        // ����ꥹ�Ȥκ���
        for ( std::map< std::string, var_t >::const_iterator iter( order_list_map.begin() ), last( order_list_map.end() );
          iter != last;
          ++iter )
        {
          // �и���ꥹ�� $OBJ.ORDER_LIST$ -- ID�ֹ���¤�
          mproc.set_var( toppers::toupper( iter->first + ".order_list" ), iter->second );
          var_t rorder_list( iter->second );

          // �ս�ꥹ�� $OBJ.RORDER_LIST$ -- ID�ֹ���¤�
          std::reverse( rorder_list.begin(), rorder_list.end() );
          mproc.set_var( toppers::toupper( iter->first + ".rorder_list" ), rorder_list );

          // ID�ֹ�ꥹ�� $OBJ.ID_LIST$ -- ID�ֹ���¤�
          var_t id_list( iter->second );
          std::sort( id_list.begin(), id_list.end() );
          mproc.set_var( toppers::toupper( iter->first + ".id_list" ), id_list );
        }

        element external_id;
        external_id.i = get_global_bool( "external-id" );
        mproc.set_var( "USE_EXTERNAL_ID", var_t( 1, external_id ) );
      }


      // �ץ�åȥե����ࡦ����ѥ����¸���ͤ�ޥ����ץ����å����ѿ��Ȥ������ꤹ�롣
      void set_platform_vars( cfg1_out const& cfg1out, macro_processor& mproc )
      {
        typedef macro_processor::element element;
        typedef macro_processor::var_t var_t;

        cfg1_out::cfg1_def_table const* def_table = cfg1out.get_def_table();
        std::size_t sizeof_signed_t;
        std::size_t sizeof_pointer;

        static cfg1_out::cfg1_def_t const limit_defs[] = {};

        nm_symbol::entry nm_entry = cfg1out.get_syms()->find( "TOPPERS_cfg_sizeof_signed_t" );
        sizeof_signed_t = static_cast< std::size_t >( cfg1out.get_srec()->get_value( nm_entry.address, 4, cfg1out.is_little_endian() ) );

        nm_entry = cfg1out.get_syms()->find( "TOPPERS_cfg_sizeof_pointer" );
        sizeof_pointer = static_cast< std::size_t >( cfg1out.get_srec()->get_value( nm_entry.address, 4, cfg1out.is_little_endian() ) );

        for ( std::size_t i = 0; i < sizeof limit_defs / sizeof limit_defs[ 0 ]; ++i )
        {
          element e;
          e.s = limit_defs[ i ].expression;
          nm_entry = cfg1out.get_syms()->find( limit_defs[ i ].name );
          std::tr1::int64_t value = cfg1out.get_srec()->get_value( nm_entry.address, sizeof_signed_t, cfg1out.is_little_endian() );
          if ( sizeof_signed_t < 8 && limit_defs[ i ].is_signed )
          {
            value = cfg1_out::make_signed( static_cast< std::tr1::uint32_t >( value ) );
          }
          mproc.set_var( e.s, var_t( 1, e ) );
        }

        for ( cfg1_out::cfg1_def_table::const_iterator iter( def_table->begin() ), last( def_table->end() );
          iter != last;
          ++iter )
        {
          element e;
          std::tr1::int64_t value;

          nm_entry = cfg1out.get_syms()->find( "TOPPERS_cfg_" + iter->name );
          if ( nm_entry.type >= 0 )
          {
            if ( !iter->expression.empty() && iter->expression[ 0 ] == '@' )  // ����'@'�ǻϤޤ���ϥ��ɥ쥹�����
            {
              value = cfg1out.get_srec()->get_value( nm_entry.address, sizeof_pointer, cfg1out.is_little_endian() );
              if ( sizeof_signed_t < 8 && iter->is_signed )
              {
                value = cfg1_out::make_signed( static_cast< std::tr1::uint32_t >( value ) );
              }

              // ��ۤɼ��Ф������ɥ쥹��Ȥäƴ��ܻ���
              value = cfg1out.get_srec()->get_value( value, 8, cfg1out.is_little_endian() );  // ���Ф��ͤϷ��˴ط��ʤ����8�Х���
              if ( sizeof_signed_t < 8 && iter->is_signed )
              {
                value = cfg1_out::make_signed( static_cast< std::tr1::uint32_t >( value ) );
              }
              e.s = iter->expression.c_str() + 1; // ��Ƭ��'@'�����
            }
            else  // ���ɥ쥹�ǤϤʤ��̾�����������
            {
              value = cfg1out.get_srec()->get_value( nm_entry.address, sizeof_signed_t, cfg1out.is_little_endian() );
              if ( sizeof_signed_t < 8 && iter->is_signed )
              {
                value = cfg1_out::make_signed( static_cast< std::tr1::uint32_t >( value ) );
              }
              e.s = iter->expression;
            }
            e.i = value;
            mproc.set_var( iter->name, var_t( 1, e ) );
          }
        }

        // �Х��ȥ�������
        {
          bool little_endian = cfg1out.is_little_endian();
          element e;
          e.i = little_endian;
          mproc.set_var( "LITTLE_ENDIAN", var_t( 1, e ) );

          e.i = !little_endian;
          mproc.set_var( "BIG_ENDIAN", var_t( 1, e ) );
        }
      }

    }

    //! ���󥹥ȥ饯��
    factory::factory( std::string const& kernel )
      : kernel_( tolower( kernel ) )
    {
    }

    //! �ǥ��ȥ饯��
    factory::~factory()
    {
    }

    //! ���ݡ��Ȥ��Ƥ��륪�֥������Ⱦ���μ���
    std::map<std::string, toppers::xml::info> const* factory::get_container_info_map() const
    {
      // CSV����Container������ɤ߼�ꡢ��Ͽ���뤿��Υ������륯�饹
      struct init_t
      {
        init_t()
        {
          boost::any t = global( "api-table" );
          if ( !t.empty() )
          {
            std::vector< std::string > api_tables( boost::any_cast< std::vector< std::string >& >( t ) );
            for ( std::vector< std::string >::const_iterator iter( api_tables.begin() ), last( api_tables.end() );
                  iter != last;
                  ++iter )
            {
              std::string buf;
              std::string api_table_filename = *iter;
              read( api_table_filename.c_str(), buf );
              csv data( buf.begin(), buf.end() );
              for ( csv::const_iterator d_iter( data.begin() ), d_last( data.end() );
                    d_iter != d_last;
                    ++d_iter )
              {
                csv::size_type len = d_iter->size();
                if ( len < 2 )  // container full-path, container rename,��ɬ������
                {
                  toppers::fatal( _( "too little fields in `%1%\'" ), *iter );
                }

                toppers::xml::info  xml_info= { 0 };
                try
                {
                  char* s;
                  s = new char[ ( *d_iter )[ 1 ].size() + 1 ];
                  std::strcpy( s, ( *d_iter )[ 1 ].c_str() );
                  xml_info.tfname = s;

                  s = new char[ ( *d_iter )[ 2 ].size() + 1 ];
                  std::strcpy( s, ( *d_iter )[ 2 ].c_str() );
                  xml_info.type = s;
                  if( strlen(s) )
                  {
                    if( !strcmp( s, "INT" ) )
                        xml_info.type_enum = toppers::xml::container::TYPE_INT;
                    else if( !strcmp( s, "FLOAT" ) )
                        xml_info.type_enum = toppers::xml::container::TYPE_FLOAT;
                    else if( !strcmp( s, "STRING" ) || !strcmp( s, "+STRING" ) )
                        xml_info.type_enum = toppers::xml::container::TYPE_STRING;
                    else if( !strcmp( s, "BOOLEAN" ) )
                        xml_info.type_enum = toppers::xml::container::TYPE_BOOLEAN;
                    else if( !strcmp( s, "ENUM" ) )
                        xml_info.type_enum = toppers::xml::container::TYPE_ENUM;
                    else if( !strcmp( s, "REF" ) )
                        xml_info.type_enum = toppers::xml::container::TYPE_REF;
                    else if( !strcmp( s, "FUNCTION" ) )
                        xml_info.type_enum = toppers::xml::container::TYPE_FUNCTION;
                    else if( !strcmp( s, "INCLUDE" ) || !strcmp( s, "+INCLUDE" ))
                        xml_info.type_enum = toppers::xml::container::TYPE_INCLUDE;
                  }

                  if ( len >= 4 && !( *d_iter )[ 3 ].empty() )
                  {
                    try
                    {
                      string multi = ( *d_iter )[ 3 ].c_str();
                      xml_info.multimin = boost::lexical_cast<int>(multi);
                      xml_info.multimax = xml_info.multimin;
                    }
                    catch(...)
                    {
                      toppers::fatal( _( "Invalid parameter fields in `%1%\'" ), *iter );
                    }
                  }
                  if ( len >= 5 && !( *d_iter )[ 4 ].empty() )
                  {
                    if("*" == ( *d_iter )[ 4 ])
                    {
                      xml_info.multimax = -1;  // unsigned int�κ�����
                    }
                    else
                    {
                      try
                      {
                        xml_info.multimax = boost::lexical_cast<int>(( *d_iter )[ 4 ].c_str());
                      }
                      catch(...)
                      {
                        toppers::fatal( _( "Invalid parameter fields in `%1%\'" ), *iter );
                      }
                    }
                  }
                  container_table_[ (*d_iter)[0].c_str() ] = xml_info;
                }
                catch( ... )
                {
                  delete[] xml_info.type;
                  delete[] xml_info.tfname;
                  throw;
                }
              }
            }
          }
        }

        ~init_t()
        {
          for ( std::map< std::string, toppers::xml::info >::const_iterator iter( container_table_.begin() ), last( container_table_.end() );
                iter != last;
                ++iter )
          {
            delete[] iter->second.type;
            delete[] iter->second.tfname;
          }
        }

        std::map< std::string, toppers::xml::info > container_table_;
      };
      static init_t init;
      std::map< std::string, toppers::xml::info > const* result = &init.container_table_;
      return result;
    }

    /*!
     * \brief   cfg1_out.c �ؤν��Ͼ���ơ��֥������
     * \return  �������� cfg1_out::cfg1_def_table ���֥������ȤؤΥݥ���
     * \note    ���δؿ����֤��ݥ��󥿤� delete ���ƤϤʤ�ʤ�
     *
     * --cfg1-def-table ���ץ����ǻ��ꤷ���ե����뤫�顢cfg1_out.c �ؽ��Ϥ��������ɤ߼�ꡢ
     * cfg1_out::cfg1_def_table ���֥������Ȥ��������롣
     *
     * CSV �η����ϰʲ����̤�
     *
     *    ����ܥ�̾,��[,s|signed]
     *
     * ������ s �ޤ��� signed �Ͼ�ά��ǽ����ά�������̵�������Ȥߤʤ���s �ޤ��� signed �������
     * ����դ������Ȥߤʤ���\n
     * �ּ��פκǽ�� # ����������������Ȥߤʤ���
     */
    cfg1_out::cfg1_def_table const* factory::get_cfg1_def_table() const
    {
      struct init_t
      {
        init_t()
        {
          boost::any t = global( "cfg1-def-table" );
          if ( !t.empty() )
          {
            std::vector< std::string > cfg1_def_table = boost::any_cast< std::vector< std::string >& >( t );
            for ( std::vector< std::string >::const_iterator iter( cfg1_def_table.begin() ), last( cfg1_def_table.end() );
                  iter != last;
                  ++iter )
            {
              std::string buf;
              read( iter->c_str(), buf );
              csv data( buf.begin(), buf.end() );
              for ( csv::const_iterator d_iter( data.begin() ), d_last( data.end() );
                    d_iter != d_last;
                    ++d_iter )
              {
                csv::size_type len = d_iter->size();
                if ( len < 2 )
                {
                  toppers::fatal( _( "too little fields in `%1%\'" ), *iter );
                }
                cfg1_out::cfg1_def_t def = { 0 };
                def.name = ( *d_iter )[ 0 ];
                def.expression = ( *d_iter )[ 1 ];
                if ( len >= 3 )
                {
                  std::string is_signed( ( *d_iter )[ 2 ] );
                  def.is_signed = ( is_signed == "s" || is_signed == "signed" );
                }
                if ( len >= 4)
                {
                  def.value1 = ( *d_iter )[ 3 ];
                }
                if ( len >= 5)
                {
                  def.value2 = ( *d_iter )[ 4 ];
                }
                cfg1_def_table_.push_back( def );
              }
            }
          }
        }
        cfg1_out::cfg1_def_table cfg1_def_table_;
      };
      static init_t init;
      cfg1_out::cfg1_def_table const* result = &init.cfg1_def_table_;
      return result;
    }

    //! ���֥������Ȥθ�
    void factory::do_swap( factory& other )
    {
      kernel_.swap( other.kernel_ );
    }

    /*!
     *  \brief  �ޥ����ץ����å�������
     *  \param[in]  cfg1out cfg1_out ���֥�������
     *  \param[in]  api_map .cfg �ե�����˵��Ҥ��줿��ŪAPI����
     *  \return     �ޥ����ץ����å��ؤΥݥ���
     *  \note   ���Υ��дؿ��Ͻ�����͡ʥ��եȥ������������б��ǡˤβ�¸�Τ���ˤ��Τޤ޻Ĥ���
     */
    std::auto_ptr< macro_processor > factory::do_create_macro_processor( cfg1_out const& cfg1out, cfg1_out::xml_obj_map const& xml_map ) const
    {
      typedef macro_processor::element element;
      typedef macro_processor::var_t var_t;
      std::auto_ptr< macro_processor > mproc( new macro_processor );
      element e;

      e.s = " ";    mproc->set_var( "SPC", var_t( 1, e ) );  // $SPC$
      e.s = "\t";   mproc->set_var( "TAB", var_t( 1, e ) );  // $TAB$
      e.s = "\n";   mproc->set_var( "NL",  var_t( 1, e ) );  // $NL$

      // �С���������
      e.s = toppers::get_global_string( "version" );
      e.i = toppers::get_global< std::tr1::int64_t >( "timestamp" );
      mproc->set_var( "CFG_VERSION", var_t( 1, e ) );   // $CFG_VERSION$

      // �ѥ�����
      e.s = boost::lexical_cast< string >( toppers::get_global< int >( "pass" ) );
      e.i = toppers::get_global< int >( "pass" );
      mproc->set_var( "CFG_PASS", var_t( 1, e ) );

      // CFG_XML�ѿ�
      e.s = "1";
      e.i = 1;
      mproc->set_var( "CFG_XML",  var_t( 1, e ) );

      // ����¾���Ȥ߹����ѿ�������
      set_object_vars( cfg1out, xml_map, *mproc );
      set_platform_vars( cfg1out, *mproc );
      e.s = cfg1out.get_includes();
      e.i = boost::none;
      mproc->set_var( "INCLUDES", var_t( 1, e ) );
      return mproc;
    }

    std::auto_ptr< cfg1_out > factory::do_create_cfg1_out( std::string const& filename ) const
    {
      return std::auto_ptr< xml::cfg1_out >( new cfg1_out( filename, get_cfg1_def_table() ) );
    }
    std::auto_ptr< checker > factory::do_create_checker() const
    {
      return std::auto_ptr< xml::checker >( new checker );
    }

  }
}